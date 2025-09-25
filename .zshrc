# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -n "$ZSH_DEBUGRC" ]]; then
        zmodload zsh/zprof
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:$HOME/.cargo/bin/"

export EDITOR=nvim

LLS_Addons=$HOME/.config/nvim/LLS-Addons/

export FZF_DEFAULT_OPTS='
--color=fg:#6c7086,fg+:,bg:,bg+:#11111b
--color=hl:#cdd6f4,hl+:#F38BA8,info:#f9e2af,marker:#F38BA8
--color=prompt:#f9e2af,spinner:#f9e2af,pointer:#af5fff,header:#ababab
--color=gutter:#11111b,border:#11111b,label:#cdd6f4,query:#cdd6f4
--border="none" --border-label-pos="0" --preview-window="border-bold"
--padding="1" --margin="0" --prompt="> " --marker="󰨓 "
--pointer="" --separator="" --scrollbar="" --layout="reverse" --preview-window=right,60%'

GOPATH=/home/q/go/bin

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Path to powerlevel10k theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# List of plugins used
plugins=( z git fzf sudo zsh-syntax-highlighting )
# source "$ZSH"/oh-my-zsh.sh

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
        local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
        printf 'zsh: command not found: %s\n' "$1"
        local entries=( '${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}' )
        if (( ${#entries[@]} )) ; then
                printf "${bright}$1${reset} may be found in the following packages:\n"
                local pkg
                for entry in "${entries[@]}" ; do
                        local fields=( "${(0)entry}" )
                        if [[ "$pkg" != "${fields[2]}" ]] ; then
                                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
                        fi
                        printf '    /%s\n' "${fields[4]}"
                        pkg="${fields[2]}"
                done
        fi
        return 127
}

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
        aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
        aurhelper="paru"
fi

function in {
        local -a inPkg=("$@")
        local -a arch=()
        local -a aur=()

        for pkg in "${inPkg[@]}"; do
                if pacman -Si "$pkg" &>/dev/null; then
                        arch+=("$pkg")
                else
                        aur+=("$pkg")
                fi
        done

        if [[ ${#arch[@]} -gt 0 ]]; then
                sudo pacman -S "${arch[@]}"
        fi

        if [[ ${#aur[@]} -gt 0 ]]; then
                "$aurhelper" -S "${aur[@]}"
        fi
}

# Helpful aliases
alias          c='clear'
alias          l='eza -lh  --icons=auto'
alias         ls='eza --tree --level=1 --icons=always --no-time --no-user --no-permissions'
alias        ls2='eza --tree --level=2 --icons=always --no-time --no-user --no-permissions'
alias        ls3='eza --tree --level=2 --icons=always --no-time --no-user --no-permissions'
alias         lt='eza --tree --icons=always --no-time --no-user --no-permissions'
alias         ld='eza -lhD --icons=auto'
alias         un='$aurhelper -Rns'
alias         up='clear && fastfetch -c ~/.config/fastfetch/pac.jsonc && $aurhelper -Syu'
alias         pl='$aurhelper -Qs'
alias         pa='$aurhelper -Ss'
alias         pc='$aurhelper -Sc'
alias         po='$aurhelper -Qtdq | $aurhelper -Rns -'
alias          S='sudo pacman -S'
alias          b='btm'
alias          h='htop'

alias          f='clear && fastfetch -c ~/.config/fastfetch/arch.jsonc'
alias         sz='clear && source ~/.zshrc && clear'
alias         sb='clear && source ~/.bashrc && clear'
alias          n='nvim'
alias          t='tmux'
alias    yayfind='$aurhelper -Slq | fzf --border-label="yay" --multi --preview "$aurhelper -Si {1}" | xargs -ro $aurhelper -S'
alias    pacfind='pacman -Slq | fzf --multi --border-label="pacman" --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'

alias         gpp='g++'
alias         nvz='nvim ~/.config/.zshrc'
alias         inv='clear && nvim $(fzf -m --preview="bat --color=always {}") && clear'
alias         cnv='clear && rm -rf ~/.config/nvim && rm -rf ~/.local/share/nvim && rm -rf ~/.local/state/nvim && rm -rf ~/.cache/nvim'
alias         fzf='fzf -m --preview="bat --color=always {}"'
alias           p='clear && goplaying && clear'
alias         btc='clear && bluetoothctl connect 2C:BE:EB:71:C9:5C'
alias         btd='clear && bluetoothctl disconnect 2C:BE:EB:71:C9:5C'
alias       clock='clear && tty-clock -c && clear'
alias         umx='clear && unimatrix --color=red -a -f -n -s 97 -l o && clear'
alias         cmx='clear && cmatrix && clear'
alias     arttime='arttime --nolearn -a skull3 --hours 24 -t "Nothing ever lasts forever"'

alias           2='hyprctl dispatch exit'
alias           1='reboot'
alias           0='shutdown now'
alias           .='exec Hyprland'
# alias .=' /usr/lib/plasma-dbus-run-session-if-needed \
#         /usr/bin/startplasma-wayland'

# Handy change dir shortcuts
alias          ..='cd ..'
alias         ...='cd ../..'
alias          .3='cd ../../..'
alias          .4='cd ../../../..'
alias          .5='cd ../../../../..'
alias    start_12='/usr/lib/jvm/java-8-openjdk/jre/bin/java -Xmx1024M -Xms1024M -jar forge-1.12.2-14.23.5.2860.jar nogui'
alias    start_21='/usr/lib/jvm/java-23-openjdk/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui'
alias    start_20='/usr/lib/jvm/java-24-openjdk/bin/java -Xmx6144M -Xms1024M -jar fabric-server-mc.1.20.1-loader.0.16.10-launcher.1.0.1.jar nogui'

# Tmux
alias          ta='tmux attach'

# Git aliases
alias        dots='git add --all && git commit --allow-empty-message -m "" && git push && clear'
alias          ga='git add --all'
alias          gc='git commit -m 1'
alias          gp='git push'
alias          lg='lazygit'

# create git repo
repo() {
        git init
        git add --all
        git commit --allow-empty-message -m ""
        git remote add origin  "$0"
        git branch -M main
        git push -u origin main
}

# Select Ghostty shader
shader() {
        shader="$(find "$HOME/.config/ghostty/shaders/" -type f | fzf)"
        if [[ -n "$shader" ]]; then
                escaped_shader=$(printf '%s\n' "$shader" | sed 's/[&/\]/\\&/g')
                sed -i "s|\(custom-shader = \).*|\1$escaped_shader|" "$HOME/.config/ghostty/config"
        fi
}

# FFmpeg aliases
mp3() {
        ffmpeg -i "$1" -q:a 0 -map a "$1.mp3"
}

# Compile and run C/C++ file
crun() {
        if [[ -z "$1" ]]; then
                return 1
        fi

        local src="$1"
        local outfile="${src}.out"

        if [[ "$src" == *.cpp ]]; then
                clang++ -std=c++17 "$src" -o "$outfile" && ./"$outfile"
        elif [[ "$src" == *.c ]]; then
                clang "$src" -o "$outfile" && ./"$outfile"
        else
                echo "Unsupported file type: $src"
                return 1
        fi
}

# Yazi wrapper
y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
}

# Select neovim config
vv() {
        local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
        [[ -z $config ]] && echo "No config selected" && return
        NVIM_APPNAME=$(basename "$config") nvim "$@"
}

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

EDTOR='nvim'

source <(fzf --zsh)

HISTSIZE=10000
HISTFILE=~/.zsh_histrory
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu-no
zstyle ':fzf-tab:complete:cd*' fzf-preview 'ls --color $realpath'

eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd cd zsh)"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/bin

fpath+=~/.zfunc; autoload -Uz compinit; compinit

bindkey -s "^p" 'yayfind \n'
bindkey -s "^z" 'zi \n'
bindkey -s "^h" 'cd \n'
bindkey -s "^h" 'cd \n'
bindkey -s "^k" 'c \n'
bindkey -s "^l" 'ls \n'
bindkey -s "^f" 'fg \n'
# bindkey -s "^\\ " 'n \n'
# bindkey -s "^\\ " 'y \n'
bindkey -s "^\\ " 'fzf \n'
bindkey -s "^n" 'n \n'
bindkey -s "^y" 'y \n'
bindkey -s "^[g" 'dots \n'
bindkey -s "^[b" 'b \n'
bindkey -s "^[z" 'sz \n'
bindkey -s "^[t" 'ta \n'
bindkey -s "^[u" 'up \n'

if [[ -n "$ZSH_DEBUGRC" ]]; then
        zprof
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/q/.lmstudio/bin"
# End of LM Studio CLI section
