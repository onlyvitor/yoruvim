# Yoruvim

Configuracao em Lua para Neovim 0.12 ou superior. O diretorio inteiro fica em
`~/.config/nvim/`. `init.lua` inicia o Lazy.nvim; `lua/yoruvim/core/` contem
preferencias, atalhos e comandos; `lua/yoruvim/plugins/` contem os plugins;
`lua/yoruvim/lsp/` configura servidores; `lua/yoruvim/utils/` detecta projetos;
`after/ftplugin/` ajusta a escrita por tipo de arquivo. `lazy-lock.json` fixa
as revisoes instaladas e deve acompanhar a configuracao.

O ramo atual `main` de nvim-treesitter requer Neovim 0.12 e
`tree-sitter-cli >= 0.26.1`. O LSP utiliza `vim.lsp.config`/`vim.lsp.enable`;
`vtsls` substitui a antiga configuracao `tsserver`. O nvim-cmp foi escolhido
por estabilidade e ausencia de binario adicional. Snacks concentra painel
inicial, busca, explorador, historico Git e terminal. A statusline mostra os
buffers, sem bufferline separado nem fonte especial obrigatoria.

## Instalacao no Linux

Ubuntu/Debian (os nomes dos pacotes podem variar entre versoes):

```sh
sudo apt update
sudo apt install git curl tar build-essential clang clangd clang-format clang-tidy gdb cmake ninja-build ripgrep nodejs npm
```

Fedora:

```sh
sudo dnf install git curl tar gcc gcc-c++ make clang clang-tools-extra gdb cmake ninja-build ripgrep nodejs npm
```

Arch Linux:

```sh
sudo pacman -Syu git curl tar base-devel clang gdb cmake ninja ripgrep nodejs npm
```

O pacote `neovim` da distribuicao so serve se `nvim --version` mostrar 0.12
ou superior. Para instalar o binario oficial 0.12.5 em Linux x86_64:

```sh
mkdir -p "$HOME/.local/opt" "$HOME/.local/bin"
curl -fL https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-x86_64.tar.gz -o /tmp/nvim-linux-x86_64.tar.gz
tar -xzf /tmp/nvim-linux-x86_64.tar.gz -C "$HOME/.local/opt"
ln -sfn "$HOME/.local/opt/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin/nvim"
export PATH="$HOME/.local/bin:$PATH"
nvim --version
```

Em ARM64, substitua `x86_64` por `arm64` nos tres caminhos acima. Inclua
`$HOME/.local/bin` permanentemente no PATH do seu shell. Em sistemas com glibc
antiga, consulte os requisitos do binario oficial.

Rust, servidores e formatadores:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer rustfmt clippy
cargo install tree-sitter-cli --locked
npm install -g @vtsls/language-server vscode-langservers-extracted bash-language-server prettier
```

Abra outro shell apos instalar Rust. Verifique as ferramentas com:

```sh
for c in cargo tree-sitter rust-analyzer rustfmt clangd vtsls vscode-json-language-server prettier rg gdb node npm; do command -v "$c" || echo "AUSENTE: $c"; done
```

Opcionalmente instale `stylua` com `cargo install stylua --locked` e `shfmt`
pelo gerenciador do sistema. `gcc`/`g++` ou `clang`/`clang++`, `make` e CMake
compilam C/C++. `rustfmt` vem do `rustup`; `clang-format` vem do pacote do
sistema. Para editar esta propria configuracao com LSP de Lua, instale
opcionalmente `lua-language-server`.

Copie a arvore completa para `~/.config/nvim/` e execute `nvim`. O `init.lua`
clona automaticamente Lazy.nvim em `~/.local/share/nvim/lazy/lazy.nvim` (Git e
internet necessarios na primeira abertura). Para instalar manualmente:

```sh
git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git "$HOME/.local/share/nvim/lazy/lazy.nvim"
```

Em Neovim, execute `:Lazy sync` e aguarde a instalacao dos parsers Treesitter
ou execute `:TSInstall c cpp rust javascript typescript tsx json lua markdown
markdown_inline bash vimdoc`. `:TSUpdate` atualiza parsers apos `:Lazy update`;
`:checkhealth nvim-treesitter` e `:TSLog` ajudam a identificar falhas.

## Projetos e linguagens

Abra o diretorio raiz com `nvim .` ou um arquivo com `nvim src/main.rs`.
As operacoes `:Build`, `:Run`, terminal e ESLint procuram, subindo a arvore,
`Cargo.toml`, `package.json`, `CMakeLists.txt`, `Makefile` e `.git`. O LSP
clangd reconhece tambem `compile_commands.json` e `compile_flags.txt`; o
vtsls reconhece `tsconfig.json` e `jsconfig.json`. Os demais servidores usam
as regras oficiais do nvim-lspconfig. O diretorio de trabalho do editor nao
e alterado automaticamente.

- C/C++: `clangd`, `clang-format` e diagnosticos/clang-tidy via clangd.
  CMake: `cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON`;
  `:Build` configura e compila. Com Make, produza `compile_commands.json`
  usando `bear -- make` (instale `bear`) ou use `compile_flags.txt` para
  projetos simples. Um arquivo isolado compila com `cc`/`c++ -g` e gera
  executavel ao lado do fonte. `:Run` usa `make run` quando existe esse alvo;
  para CMake ou Make sem alvo `run`, pede o caminho do executavel.
- Rust: `rustup component add rust-analyzer rustfmt clippy`; abra um projeto
  criado com `cargo new exemplo`. `:Build` chama `cargo build`, `:Run` chama
  `cargo run`, `:Lint` chama `cargo clippy` e publica diagnosticos. O
  rust-analyzer executa `cargo check` em segundo plano.
- Node.js/TypeScript: `npm init -y`, `npm install -D typescript prettier eslint`
  e, para TypeScript, `npx tsc --init`. Crie o arquivo de regras com
  `npm init @eslint/config@latest`. `:Build` executa o script `build` do
  `package.json`; `:Run` prefere `dev`, depois `start`. Sem package.json,
  `:Run` executa o JS atual com `node`. Instale ESLint no projeto e
  `:Lint` publica diagnosticos; ao salvar JS/TS ele roda automaticamente
  quando existe `node_modules/.bin/eslint`. A formatacao usa o Prettier
  local quando disponivel e o global como alternativa. No projeto, use
  `npm install` para obter dependencias locais.

`<leader>lo` organiza imports quando o servidor oferece essa acao. Para
formatar, use `:Format` ou `<leader>cf`. `:FormatToggle` liga/desliga a
formatacao ao salvar (desligada por padrao, apenas na sessao atual). Se
quiser o comportamento permanente, mude `local autoformat = false` em
`lua/yoruvim/plugins/format.lua` para `true`. `:ConformInfo` mostra os
formatadores disponiveis. `:Diagnostics` abre os diagnosticos pesquisaveis.

## Depuracao

O DAP usa GDB com suporte a `--interpreter=dap` (GDB 14 ou superior) para C,
C++ e Rust. Compile com simbolos (`-g`; CMake: `-DCMAKE_BUILD_TYPE=Debug`,
Rust `cargo build` ja os produz) e escolha o executavel quando solicitado.
Para Node.js, instale o adaptador oficial Microsoft js-debug:

```sh
mkdir -p "$HOME/.local/share/nvim/dap"
curl -fL https://github.com/microsoft/vscode-js-debug/releases/download/v1.140.0/js-debug-dap-v1.140.0.tar.gz -o /tmp/js-debug-dap.tar.gz
tar -xzf /tmp/js-debug-dap.tar.gz -C "$HOME/.local/share/nvim/dap"
test -f "$HOME/.local/share/nvim/dap/js-debug/src/dapDebugServer.js"
```

`<leader>dc` inicia/continua, `<leader>db` alterna breakpoint. Para TS,
compile (`npx tsc` ou script `build`) e indique o JS emitido no prompt do
debugger. Para anexar a Node, inicie `node --inspect app.js` e escolha o
processo com a configuracao `Node: processo (--inspect)`. Configuracoes
especificas por projeto podem ser lidas de `.vscode/launch.json` pelo
`nvim-dap`; confira `:help dap-launch.json` para as limitacoes de JSON.

## Escrita

Markdown, texto e mensagens Git usam quebra visual inteligente e corretor
ortografico por arquivo. `spelllang=en` funciona com o dicionario incluido
no Neovim. Para portugues brasileiro, gere a lista binaria do Vim a partir
dos dicionarios do LibreOffice (`:mkspell` e nativo do Neovim; nao requer o
programa hunspell):

```sh
mkdir -p "$HOME/.local/share/hunspell" "$HOME/.local/share/nvim/site/spell"
curl -fL -o "$HOME/.local/share/hunspell/pt_BR.aff" https://raw.githubusercontent.com/LibreOffice/dictionaries/master/pt_BR/pt_BR.aff
curl -fL -o "$HOME/.local/share/hunspell/pt_BR.dic" https://raw.githubusercontent.com/LibreOffice/dictionaries/master/pt_BR/pt_BR.dic
nvim --clean --headless "+mkspell! $HOME/.local/share/nvim/site/spell/pt-br $HOME/.local/share/hunspell/pt_BR" '+qa!'
test -f "$HOME/.local/share/nvim/site/spell/pt-br.utf-8.spl"
```

No Ubuntu/Debian os mesmos arquivos tambem vem do pacote `hunspell-pt-br`
(`/usr/share/hunspell/pt_BR.aff` e `pt_BR.dic`), bastando trocar o caminho
do segundo argumento do `:mkspell`. O resultado e `pt-br.utf-8.spl`;
`<leader>wl` alterna `en`, `pt-br` e `en,pt-br` no buffer atual,
`<leader>ws` liga/desliga a verificacao na janela atual. `]s`/`[s` navegam
erros, `z=` sugere correcoes e `zg` aceita palavras.
A contagem de palavras aparece na statusline em Markdown, texto e mensagens
Git. A largura visual nao altera as linhas armazenadas no arquivo.

## Interface, atualizacao e diagnostico

`<leader>e` abre o explorador com status Git. Dentro dele, `<CR>` abre, `a`
cria arquivo (adicione `/` ao fim para diretorio), `r` renomeia, `d` exclui,
`<Tab>` seleciona varios, `m` move, `c` copia, `y` copia caminhos, `p` cola,
`h` fecha diretorio, `<BS>` sobe, `H` mostra ocultos, `]g`/`[g` percorrem
mudancas Git. Em seguida, use `<leader>gg` para status, `<leader>gd` para
diff, `<leader>gh` para historico e `<leader>gB` para branches.

`<leader>tt` abre/oculta o terminal inferior nos modos normal e terminal;
`<C-h/j/k/l>` troca de janela. Em modo normal no terminal, `q` o oculta;
`<leader>tk` elimina o buffer de terminal. O terminal usado para build/run
fica aberto depois do comando para facilitar a leitura da saida.

`:Lazy update` atualiza plugins e o lockfile; `:Lazy restore` reaplica o
lockfile; `:Lazy clean` remove plugins retirados da lista; `:TSUpdate`
sincroniza parsers. Para remover um plugin, remova sua especificacao em
`lua/yoruvim/plugins/`, seus atalhos correspondentes, rode `:Lazy clean` e
reinicie. Para adicionar, crie um arquivo Lua que retorne uma tabela de
especificacoes e importe-o em `lua/yoruvim/plugins/init.lua`.
Para trocar o tema, instale o plugin de tema desejado em `plugins/init.lua`
e ajuste `vim.cmd.colorscheme` em `init.lua`.

Solucao de problemas: `:checkhealth`, `:checkhealth vim.lsp`, `:LspInfo`,
`:LspLog`, `:lsp restart`, `:ConformInfo`, `:checkhealth nvim-treesitter`,
`:TSLog`, `:Lazy`, `:messages` e `:lua print(vim.bo.filetype)` mostram o
estado real. LSP nao inicia: verifique `command -v clangd rust-analyzer vtsls`
individualmente e a raiz (`:lua print(require('yoruvim.utils.project').root())`).
No `:LspLog`, `invalid "clangd" config: ... clangd is not executable` indica
apenas que aquele servidor nao esta no PATH (instale-o; os demais seguem
funcionando); `Unknown binary 'rust-analyzer' in official toolchain` resolve
com `rustup component add rust-analyzer`.
Arvore sintatica nao aparece: confira `tree-sitter --version`, `cc --version`,
`:TSInstall rust` e `:checkhealth nvim-treesitter`. Erro em `:Lint` de ESLint:
instale as dependencias com `npm install` e forneca um `eslint.config.js`.
Sem formatacao: instale o executavel correspondente e rode `:ConformInfo`.
Sem sugestoes pt-br: confira o nome exato do arquivo de dicionario e reinicie.
GDB sem DAP: atualize-o para a versao 14 ou superior. Depuracao Node sem
adaptador: confirme o caminho com o comando `test` acima.

## Atalhos

Leader e Espaco. `n` significa modo normal, `t` modo terminal, `i` modo
insercao; atalhos de LSP so existem apos o servidor conectar ao buffer;
atalhos de hunks so existem em arquivos rastreados pelo Git.

| Modo | Atalho | Acao |
| --- | --- | --- |
| n | `<leader>fs`, `<leader>q`, `<leader>fn` | Salvar, sair, novo arquivo |
| n | `<leader>e`, `<leader>ff`, `<leader>fg` | Explorador, arquivos, texto |
| n | `<leader>fr`, `<leader>fp`, `<leader>fc`, `<leader>fC` | Recentes, projetos, configuracao, comandos |
| n | `<leader>bl`, `<leader>bd`, `<leader>bb`, `<leader>bp` | Listar, fechar, proximo, anterior buffer |
| n | `<leader>gg`, `<leader>gd`, `<leader>gh`, `<leader>gf`, `<leader>gB` | Status, diff, log, log do arquivo, branches |
| n | `]h`, `[h`, `<leader>gs`, `<leader>gu`, `<leader>gp`, `<leader>gb` | Hunk seguinte/anterior, stage, descartar, preview, blame |
| n | `gd`, `gD`, `gI`, `gr`, `K` | Definicao, declaracao, implementacao, referencias, hover |
| n | `<leader>la`, `<leader>lr`, `<leader>lo` | Code action, renomear, organizar imports |
| n | `<leader>ls`, `<leader>lw`, `<leader>ld`, `<leader>ll` | Simbolos locais/globais, diagnosticos, diagnostico da linha |
| n | `]d`, `[d`, `]e`, `[e` | Proximo/anterior diagnostico ou erro |
| n | `<leader>cb`, `<leader>cr`, `<leader>cf`, `<leader>cF`, `<leader>cl` | Build, run, formatar, toggle autosave, lint |
| n,t | `<leader>tt` | Mostrar/ocultar terminal |
| n | `<leader>tk` | Fechar buffer de terminal ativo |
| n | `<leader>db`, `<leader>dc`, `<leader>ds`, `<leader>di` | Breakpoint, continuar, passo sobre, passo dentro |
| n | `<leader>dt`, `<leader>dq`, `<leader>du` | Passo fora, encerrar, painel DAP |
| n | `<leader>ws`, `<leader>wl` | Alternar corretor e idiomas |
| n | `<leader>uw`, `<leader>un`, `<leader>uc` | Wrap, numeros relativos, cursorline |
| n,t | `<C-h/j/k/l>` | Trocar de janela |
| i | `<C-Space>`, `<C-n/p>`, `<C-y>`, `<C-e>` | Completar, navegar, aceitar, cancelar |
| i | `<Tab>`, `<S-Tab>` | Navegar nos itens/snippets; recua quando indisponivel |

Os atalhos de `nvim-cmp` so sao instalados em modo de insercao. `gI` foi
escolhido para implementacao, preservando o `gi` nativo do Vim. As teclas
`[d` e `]d` tem comportamento consistente tanto em codigo quanto no
explorador, cada uma em seu buffer. Se o terminal capturar o Espaco, use
`<C-\\><C-n>` para voltar ao modo normal e depois `<leader>tt`.
