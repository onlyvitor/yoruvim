local M = {}
local markers = { "Cargo.toml", "package.json", "CMakeLists.txt", "Makefile", ".git" }

function M.root()
  local name = vim.api.nvim_buf_get_name(0)
  local start = name ~= "" and vim.fs.dirname(name) or vim.fn.getcwd()
  local found = vim.fs.find(markers, { path = start, upward = true })[1]
  return found and vim.fs.dirname(found) or vim.fn.getcwd()
end

local function exists(path)
  return (vim.uv or vim.loop).fs_stat(path) ~= nil
end

local function scripts(root)
  local ok, value = pcall(vim.fn.readfile, root .. "/package.json")
  if not ok then return {} end
  local valid, data = pcall(vim.json.decode, table.concat(value, "\n"))
  return valid and type(data) == "table" and type(data.scripts) == "table" and data.scripts or {}
end

local function execute(cmd, cwd)
  if not cmd then
    vim.notify("Nao ha comando para este projeto; consulte o README.md", vim.log.levels.WARN)
    return
  end
  Snacks.terminal.open(cmd, { cwd = cwd, interactive = false, auto_close = false })
end

local function command(kind)
  local root = M.root()
  local file = vim.api.nvim_buf_get_name(0)
  local ft = vim.bo.filetype
  if exists(root .. "/Cargo.toml") then
    return kind == "build" and "cargo build" or "cargo run", root
  end
  if exists(root .. "/package.json") then
    local available = scripts(root)
    if kind == "build" then return available.build and "npm run build" or nil, root end
    if available.dev then return "npm run dev", root end
    if available.start then return "npm start", root end
    return nil, root
  end
  if exists(root .. "/CMakeLists.txt") then
    if kind == "build" then
      return "cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && cmake --build build", root
    end
    return "", root
  end
  if exists(root .. "/Makefile") then
    if kind == "build" then return "make", root end
    local ok, lines = pcall(vim.fn.readfile, root .. "/Makefile")
    if ok then
      for _, line in ipairs(lines) do
        if line:match("^run%s*:") then return "make run", root end
      end
    end
    return "", root
  end
  if file == "" then return nil, root end
  local base = vim.fn.fnamemodify(file, ":r")
  local quoted_file, quoted_base = vim.fn.shellescape(file), vim.fn.shellescape(base)
  local compiler = ({ c = "cc", cpp = "c++", rust = "rustc" })[ft]
  if compiler then
    if kind == "build" then return compiler .. " -g " .. quoted_file .. " -o " .. quoted_base, root end
    return quoted_base, root
  end
  if (ft == "javascript" or ft == "javascriptreact") and kind == "run" then
    return "node " .. quoted_file, root
  end
  return nil, root
end

function M.build()
  local cmd, root = command("build")
  execute(cmd, root)
end

function M.run()
  local cmd, root = command("run")
  if cmd == "" then
    vim.ui.input({ prompt = "Executavel (caminho absoluto ou relativo a " .. root .. "): ", completion = "file" }, function(path)
      if path and path ~= "" then execute(vim.fn.shellescape(path), root) end
    end)
  else
    execute(cmd, root)
  end
end

return M
