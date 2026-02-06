{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # Compiler Toolchains
    (lib.hiPrio gcc)
    gnumake
    cmake
    (lib.lowPrio clang)
    rustup # Rust
    nodejs_22 # Node.js (Late 2025/2026 standard)
    python3
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
  ];
}
