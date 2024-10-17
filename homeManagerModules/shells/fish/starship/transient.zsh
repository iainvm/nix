set-long-prompt() { PROMPT=$(starship prompt) }
precmd_functions+=(set-long-prompt)

set-short-prompt() {
    if [[ $PROMPT != '%# ' ]]; then
    PROMPT="$(starship prompt --profile transient)"
    zle .reset-prompt 2>/dev/null # hide the errors on ctrl+c
    fi
}

zle-line-finish() { set-short-prompt }
zle -N zle-line-finish

trap 'set-short-prompt; return 130' INT
