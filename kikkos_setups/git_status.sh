#!/usr/bin/env bash
## ~/.tmux/git_status.sh
## Returns Git repo info, CPU usage, and date for tmux status bar
#
## --------------------
## Git info
## --------------------
git_info() {
  local path="$1"
  cd "$path" 2>/dev/null || return

  if git rev-parse --git-dir >/dev/null 2>&1; then
    local repo branch staged unstaged
    repo=$(basename "$(git rev-parse --show-toplevel)")
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")
    # Only count changes if there are any
    staged=$(git diff --cached --quiet 2>/dev/null || git diff --cached --numstat 2>/dev/null | wc -l | tr -d " ")
    unstaged=$(git diff --quiet 2>/dev/null || git diff --numstat 2>/dev/null | wc -l | tr -d " ")

    echo "⎇ $repo:$branch ●$staged ●$unstaged"
  else
    echo "No Git repo"
  fi
}

# --------------------
# CPU usage
# --------------------
cpu_usage() {
  # Read first line of /proc/stat and compute CPU usage %
  read -r cpu user nice system idle iowait irq softirq steal guest < /proc/stat
  local total=$((user+nice+system+idle+iowait+irq+softirq+steal))
  local active=$((user+nice+system))
  # Simple percentage
  printf "%d%%" $((active * 100 / total))
}

# --------------------
# Date & time
# --------------------
datetime() {
  date "+%Y-%m-%d %H:%M:%S"
}

# --------------------
# Output
# --------------------
PWD_PATH="${TMUX_PANE_CURRENT_PATH:-$PWD}"

git_info "$PWD_PATH"
echo "$(git_info $PWD_PATH) | CPU: $(cpu_usage) | $(datetime)"

