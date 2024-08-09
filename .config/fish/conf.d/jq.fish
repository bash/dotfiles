# According to `man jq` the colors are in the following order:
# • color for null
# • color for false
# • color for true
# • color for numbers
# • color for strings
# • color for arrays
# • color for objects
# • color for object keys
set -x JQ_COLORS "0;35:0;33:0;33:0;33:0;32:2;39:2;39:1;34"
