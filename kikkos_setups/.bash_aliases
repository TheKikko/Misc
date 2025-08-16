# ~/.bash_aliases

export $MYSCRIPTS="/home/kikko/Source/scripts/"
# ls shortcuts
alias ls='ls --color=auto'
alias la='ls -laFq'  # hidden files
alias ll='ls -lhFq'  # human-readable sizes
alias l='ll'

# Git shortcuts
alias gbc='gb | c'
alias gcl='cd $MY_GIT_TOP && git submodule foreach --recursive "git clean -xdf" && \
           git clean -xdf -e .ccache -e .flex_dbg -e remap_catalog\*.xml -e .baseline && cd -'
alias gdt='$MYPATH/scripts/vimdiff_tabs.sh'
alias gdf='git status -s | fzf -m --preview "echo {} | cut -c4- | \
           xargs -I % git diff --color=always -- % | less"'
alias grf="git status -s | fzf -m --preview 'echo {} | cut -c4- | \
           xargs -I % git diff --color=always -- % | less' | awk '{print \$NF}' | \
           xargs git restore --source HEAD --"
alias grf2='git status -s | fzf -m --preview '\''file=$(echo {} | cut -c4-); \
             staged_diff=$(git diff --cached --color=always -- $file); \
             unstaged_diff=$(git diff --color=always -- $file); \
             { echo "Staged vs HEAD:"; echo "$staged_diff"; echo; \
               echo "Unstaged vs. staged"; echo "$unstaged_diff"; } | less -R'\'' | \
             awk '\''{print $NF}'\'' | xargs git restore --source HEAD --'
alias gaf="git status -s | fzf -m --preview 'echo {} | cut -c4- | \
           xargs -I % git diff --color=always -- % | less' | awk '{print \$NF}' | xargs git add"
alias gl='git log'
alias gusf='cd $MY_GIT_TOP; git restore --staged $(git diff --name-only --staged \
             --relative HEAD | fzf -m --preview "git diff --color HEAD -- {}"); cd -'
alias gusa='cd $MY_GIT_TOP; git restore --staged $(git diff --name-only --staged --relative HEAD); cd -'
alias go='git checkout'

# Misc
alias vimdotfiles='$EDITOR ~/.vimrc ~/.bashrc.user.alias ~/.bashrc.user \
                   $MYSCRIPTS/start_tmux* ~/.gitconfig ~/.lesshst ~/.tmux.conf'
alias resource="source ~/.bashrc && echo 'sourced!'"
