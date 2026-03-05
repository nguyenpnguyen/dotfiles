if status is-interactive
    # Commands to run in interactive sessions can go here
end
~/.local/bin/mise activate fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/nguyen/.local/bin/google-cloud-sdk/path.fish.inc' ]; . '/home/nguyen/.local/bin/google-cloud-sdk/path.fish.inc'; end
