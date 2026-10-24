#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
plugin_dir="${MATUGEN_NVIM_PLUGIN_DIR:-$script_dir/matugen-noctalia}"

nvim_config="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
plugins_dir="$nvim_config/lua/plugins"
plugin_file="$plugins_dir/matugen-noctalia.lua"
init_lua="$nvim_config/init.lua"
lazy_dir="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/lazy/lazy.nvim"

if [ ! -d "$plugin_dir/colors" ]; then
    echo "matugen-noctalia plugin not found at: $plugin_dir" >&2
    exit 1
fi

if [ -d "$lazy_dir" ]; then
    mkdir -p "$plugins_dir"
    cat > "$plugin_file" <<EOF
return {
  dir = "$plugin_dir",
  name = "matugen-noctalia",
  lazy = false,
  priority = 1000,
  config = function()
    require("matugen-noctalia").setup()
    vim.cmd.colorscheme("matugen-noctalia")
  end,
}
EOF
else
    if [ -f "$init_lua" ] && ! grep -qF "matugen-noctalia" "$init_lua"; then
        cat >> "$init_lua" <<EOF
vim.opt.rtp:prepend("$plugin_dir")
local ok, matugen = pcall(require, "matugen-noctalia")
if ok then
  matugen.setup()
  vim.cmd.colorscheme("matugen-noctalia")
end
EOF
    else
        echo "No lazy.nvim and no init.lua found, nothing written." >&2
    fi
fi

pkill -USR1 -x nvim >/dev/null 2>&1 || true
