source ~/.secrets
source /opt/homebrew/opt/asdf/libexec/asdf.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
	source ~/.aliases
end

fish_add_path /opt/homebrew/opt/libpq/bin
