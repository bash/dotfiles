# The --move is really important in cases where the .cargo/bin is
# already in the path but in the wrong place (this happens to me in VSCode on my Mac)
fish_add_path --prepend --move --path "$HOME/.cargo/bin"
set --export CARGO_REGISTRY_TOKEN "op://Development/crates.io-token/credential"
