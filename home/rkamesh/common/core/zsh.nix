{
  config,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = [ "git" ];
    };

    # Additional plugins not in oh-my-zsh
    plugins = [
      {
        name = "F-Sy-H";
        src = pkgs.fetchFromGitHub {
          owner = "z-shell";
          repo = "F-Sy-H";
          rev = "899f68b52b6b86a36cd8178eb0e9782d4aeda714";
          sha256 = "sha256-zhaXjrNL0amxexbZm4Kr5Y/feq1+2zW0O6eo9iZhmi0=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-abbr";
        src = pkgs.fetchFromGitHub {
          owner = "olets";
          repo = "zsh-abbr";
          rev = "v5.0.0";
          sha256 = "sha256-+gmHBs0gCinTR4lnVyYgMjwm1FcMCNruje7NeHH503Y=";
        };
      }
    ];

    shellAliases = {
      ls = "eza -alh --color=always --group-directories-first --icons";
      lt = "eza -aT --color=always --group-directories-first --icons";
      vi = "nvim";
    };

    initExtra = ''

      # Theme Stuff
      ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
      ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
      ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
      ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
      ZSH_THEME_GIT_PROMPT_CLEAN=""

      ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg_bold[red]%}‹"
      ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

      PROMPT='
      %{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info)$(virtualenv_prompt_info)
      $ '

      RPROMPT='$(ruby_prompt_info)'

      VIRTUAL_ENV_DISABLE_PROMPT=0
      ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX=" %{$fg[green]%}🐍 "
      ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="%{$reset_color%}"
      ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
      ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

      # History timestamp format
      HIST_STAMPS="yyyy-mm-dd"

      # Language settings
      export LANG=en_US.UTF-8

      # Editor based on SSH connection
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
      else
        export EDITOR='nvim'
      fi

      # Zoxide initialization
      eval "$(zoxide init zsh)"

      # ABBR settings
      export ABBR_SET_EXPANSION_CURSOR=1

      # CUDA settings
      export CUDA_HOME="/usr/local/cuda-12"
      export PATH="$HOME/go/bin:$HOME/.local/bin:/usr/local/cuda-12/bin:$PATH"

      # Pyenv setup
      export PYENV_ROOT="$HOME/.pyenv"
      [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init - zsh)"

      # Bun setup
      export BUN_INSTALL="$HOME/.bun"
      export PATH="$BUN_INSTALL/bin:$PATH"
      export NIXPKGS_ALLOW_UNFREE=1

      # ESP setup
      if [ -f ~/.zsh/espup_completions.zsh ]; then
        source ~/.zsh/espup_completions.zsh
      fi
      if [ -f ~/export-esp.sh ]; then
        source ~/export-esp.sh
      fi

      # Google Cloud SDK
      if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then
        source '$HOME/google-cloud-sdk/path.zsh.inc'
      fi
      if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then
        source '$HOME/google-cloud-sdk/completion.zsh.inc'
      fi
    '';
  };
}
