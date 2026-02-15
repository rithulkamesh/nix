{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # Compiler Toolchains
    (lib.hiPrio gcc)
    gnumake
    cmake
    (lib.lowPrio clang)
    llvm # LLVM toolchain for C++
    clang-tools # clang-format, clang-tidy
    rustup # Rust
    nodejs_22 # Node.js (Late 2025/2026 standard)
    go
    code-cursor
    antigravity

    # Modern CLI Tools
    ripgrep # fast grep
    fd # fast find
    bat # better cat
    eza # better ls
    fzf # fuzzy finder
    zoxide # smarter cd
    jq # json processor
    yq-go # yaml processor
    tldr # simplified man pages

    # C++ Development
    gtest # Google Test framework
    boost # C++ libraries

    # Go Development
    gopls # Go language server
    delve # Go debugger
    golangci-lint # Go linter aggregator
    go-tools # Additional Go tools

    # TypeScript/JavaScript Development
    typescript # TypeScript compiler
    nodePackages.prettier # Code formatter
    nodePackages.eslint # Linter
    nodePackages.vscode-langservers-extracted # LSP for HTML/CSS/JSON
    yarn # Package manager

    # Rust Development (beyond rustup)
    cargo-watch # Watch Rust files and rebuild
    cargo-edit # Manage dependencies

    # Debugging & Profiling
    gdb
    valgrind
    perf

    # DevOps / Containers
    docker-compose
    lazydocker
    kubectl
    minikube
    azure-cli
    docker-buildx

    # Network Tools
    dig
    nmap

    # LSP / Formatters (General)
    nixfmt-rfc-style
    shfmt
    shellcheck
    lua-language-server # Lua LSP

    # University
    ripes
  ];
}
