#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-Modules}"   # pass root dir, defaults to Modules

# Generate module boilerplate for each .nix (excluding default.nix)
gen_module_boilerplate() {
  local file="$1"
  local module
  module="$(basename "$file" .nix)"

  local ns target
  if [[ "$file" == *"/Home/"* ]]; then
    ns="home"
    target="home.packages"
  else
    ns="system"
    target="environment.systemPackages"
  fi

  cat > "$file" <<EOF
{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.${ns}.${module};
in
{
  options.nyx-module.${ns}.${module} = {
    enable = lib.mkEnableOption "Enable ${module} (${ns}) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.${module};
      description = "Package to install for ${module}.";
    };
  };

  config = lib.mkIf cfg.enable {
    ${target} = [ cfg.package ];
  };
}
EOF
  echo "Wrote boilerplate for $file"
}

gen_default_for_dir() {
  local dir="$1"
  local file="${dir}/default.nix"

  # collect non-default nix files in this directory
  local local_modules=()
  for f in "$dir"/*.nix; do
    [[ -f "$f" && "$(basename "$f")" != "default.nix" ]] && local_modules+=("./$(basename "$f")")
  done

  # if there are non-default nix files, import them
  if (( ${#local_modules[@]} > 0 )); then
    {
      echo "{ config, lib, pkgs, ... }:"
      echo
      echo "{"
      echo "  imports = ["
      for m in "${local_modules[@]}"; do
        echo "    $m"
      done
      echo "  ];"
      echo "}"
    } > "$file"

  # otherwise, import all subdirs (not their default.nix directly)
  else
    local subdirs=()
    for sub in "$dir"/*/; do
      [[ -d "$sub" && -f "$sub/default.nix" ]] && subdirs+=("./$(basename "$sub")")
    done

    {
      echo "{ config, lib, pkgs, ... }:"
      echo
      echo "{"
      echo "  imports = ["
      for s in "${subdirs[@]}"; do
        echo "    $s"
      done
      echo "  ];"
      echo "}"
    } > "$file"
  fi

  echo "Wrote default.nix in $dir"
}



# Walk the tree
echo "Generating nix module boilerplates under $ROOT ..."

# 1. Generate boilerplate for all non-default modules
find "$ROOT" -type f -name "*.nix" ! -name "default.nix" | while read -r f; do
  gen_module_boilerplate "$f"
done

# 2. Generate default.nix in every directory
find "$ROOT" -type d | while read -r d; do
  gen_default_for_dir "$d"
done

echo "Done! All modules + defaults generated."
