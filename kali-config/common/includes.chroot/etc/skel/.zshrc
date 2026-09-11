# ═══════════════════════════════════════════════════════
#  BLACK GOD LINUX — ZSH Configuration
#  Custom themed prompt, aliases, and tool shortcuts
# ═══════════════════════════════════════════════════════

# ─── Oh-My-Zsh / Plugins ──────────────────────────────
export ZSH="/usr/share/oh-my-zsh"
plugins=(git sudo command-not-found colored-man-pages)

# ─── History ───────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# ─── Black God Prompt ─────────────────────────────────
# Red skull for root, gold lightning for regular users
if [ "$EUID" -eq 0 ]; then
    PROMPT='%F{red}💀 blackgod%f %F{yellow}%~%f %F{red}# %f'
else
    PROMPT='%F{yellow}⚡ blackgod%f %F{cyan}%~%f %F{green}❯ %f'
fi

# ─── Aliases ──────────────────────────────────────────
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias cls='clear'
alias update='blackgod-update'
alias recon='blackgod-recon'
alias wifimon='blackgod-wifi'

# ─── Security Tool Quick Aliases ──────────────────────
alias msfconsole='msfconsole -q'
alias msf='msfconsole'
alias nse='ls /usr/share/nmap/scripts/ | grep'
alias serve='python3 -m http.server 8080'
alias myip='curl -s ifconfig.me && echo'
alias ports='netstat -tulanp'
alias sniff='tcpdump -i any -w capture.pcap'

# ─── Path ─────────────────────────────────────────────
export PATH="$PATH:/usr/local/bin:/usr/sbin:/sbin"

# ─── Auto-display banner on first terminal ────────────
if [ -z "$BLACKGOD_BANNER_SHOWN" ]; then
    export BLACKGOD_BANNER_SHOWN=1
    bash /etc/update-motd.d/00-black-god-banner
fi

# ─── ZSH Plugins (if installed) ──────────────────────
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
