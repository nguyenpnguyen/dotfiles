if status is-interactive
    # Commands to run in interactive sessions can go here
end
~/.local/bin/mise activate fish | source

loadenv ~/.config/fish/.env

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/nguyen/.local/bin/google-cloud-sdk/path.fish.inc' ]; . '/home/nguyen/.local/bin/google-cloud-sdk/path.fish.inc'; end

# OpenClaw Completion
source "/home/nguyen/.openclaw/completions/openclaw.fish"

set -gx OPENCODE_EXPERIMENTAL_LSP_TOOL true
set -gx OPENCODE_ENABLE_EXA true
# opencode
fish_add_path /home/nguyen/.opencode/bin
