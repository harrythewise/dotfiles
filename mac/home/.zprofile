eval "$(/opt/homebrew/bin/brew shellenv)"

export XDG_CONFIG_HOME="$HOME/.config"
export LC_ALL=en_US.UTF-8
export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=$HOME/.local/share/nvim/mason/bin:$PATH
export PATH=$HOME/.cargo/bin/:$PATH
export PATH="/opt/homebrew/opt/ruby/bin/":$PATH
export PATH="$HOME/Projects/Tools/apache-cxf/latest/bin/":$PATH
export PATH="/opt/homebrew/Cellar/llvm/21.1.0/bin":$PATH
export PATH="/opt/homebrew/Cellar/i686-elf-binutils/2.46.1/bin/":$PATH
export PATH="/opt/homebrew/Cellar/i686-elf-gcc/16.1.0/bin/":$PATH
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export ANDROID_HOME="/opt/homebrew/share/android-commandlinetools"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/tools/bin/":$PATH
export PATH="$ANDROID_HOME/emulator/":$PATH
export PATH="$ANDROID_HOME/platform-tools/":$PATH

# C/C++ specific 
SO_LIBS="/usr/local/lib":"/opt/homebrew/lib"
export LIBRARY_PATH=$SO_LIBS
export LD_LIBRARY_PATH=$SO_LIBS
export DYLD_FALLBACK_LIBRARY_PATH=$SO_LIBS

export HOMEBREW_NO_AUTO_UPDATE=1

alias vim=nvim
alias rm="trash-put"
alias cat="bat"
alias bash=/opt/homebrew/bin/bash

source <(fzf --zsh)
eval "$(direnv hook zsh)"  # or zsh, fish
