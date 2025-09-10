#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-../Modules}"   # root dir (defaults to Modules)

OUT_DIR="examples"
mkdir -p "$OUT_DIR"

OUT1="$OUT_DIR/example-with-headers-and-comments.nix"
OUT2="$OUT_DIR/example-with-headers.nix"
OUT3="$OUT_DIR/example-with-comments.nix"
OUT4="$OUT_DIR/example.nix"

echo "Generating $OUT1, $OUT2, $OUT3, $OUT4 from modules under $ROOT ..."

# --- Extract top-of-file module description ---
extract_module_description() {
  local file="$1"
  awk '
    /^ *#/ { gsub(/^ *# */, ""); print "      # " $0 }
    /^\{ *config,/ { exit }
  ' "$file"
}

# --- Extract options from a module ---
extract_options() {
  local file="$1"
  local with_comments="$2"

  grep -nE "^[[:space:]]*[a-zA-Z0-9_-]+[[:space:]]*=" "$file" \
    | grep -E "lib\.mkOption|lib\.mkEnableOption" \
    | sed -E 's/^([0-9]+):[[:space:]]*([a-zA-Z0-9_-]+)[[:space:]]*=.*/\1 \2/' \
    | while read -r line name; do
        block="$(tail -n +$((line+1)) "$file" | awk '/};/ {exit} {print}')"
        defline="$(sed -n "${line}p" "$file")"

        kind="mkOption"
        [[ "$defline" == *"mkEnableOption"* ]] && kind="mkEnableOption"

        if [[ "$kind" == "mkEnableOption" ]]; then
          [[ "$with_comments" == "yes" ]] && echo "# mkEnableOption (bool)"
          echo "${name} = true;"
        else
          otype="$(echo "$block" | grep -E "type[[:space:]]*=" | head -n1 | sed -E 's/.*type[[:space:]]*=[[:space:]]*//; s/;//')"
          value="…"
          desc=""

          if echo "$block" | grep -q "default[[:space:]]*="; then
            value="$(echo "$block" | grep "default[[:space:]]*=" | head -n1 | sed -E 's/.*default[[:space:]]*=[[:space:]]*(.*);/\1/')"
          elif echo "$block" | grep -q "example[[:space:]]*="; then
            value="$(echo "$block" | grep "example[[:space:]]*=" | head -n1 | sed -E 's/.*example[[:space:]]*=[[:space:]]*(.*);/\1/')"
          fi

          if echo "$block" | grep -q "description[[:space:]]*="; then
            desc="$(echo "$block" | grep "description[[:space:]]*=" | head -n1 | sed -E 's/.*description[[:space:]]*=[[:space:]]*//; s/^"//; s/"$//')"
            [[ -z "$value" || "$value" == "…" ]] && value="… # $desc"
          fi

          if [[ "$with_comments" == "yes" ]]; then
            [[ -n "$otype" ]] && echo "# mkOption type=$otype" || echo "# mkOption"
            [[ -n "$desc" ]] && echo "# $desc"
          fi
          echo "${name} = ${value};"
        fi
        echo
      done
}

# --- Extract module header (optional) ---
extract_header() {
  local file="$1"
  awk '
    /^ *\{ *config,/ { exit }
    /^$/ { next }
    { print "      " $0 }
  ' "$file"
}

# --- Write prolog ---
write_prolog() {
  local file="$1"
  {
    echo "{ config, lib, pkgs, ... }:"
    echo
    echo "{"
    echo "  nyx-module = {"
  } > "$file"
}

# --- Write epilog ---
write_epilog() {
  local file="$1"
  {
    echo "  };"
    echo "}"
  } >> "$file"
}

# --- Prepare all output files ---
for f in "$OUT1" "$OUT2" "$OUT3" "$OUT4"; do
  write_prolog "$f"
done

# --- Append modules for a section ---
append_modules() {
  local base="$1"
  local with_headers="$2"
  local with_comments="$3"
  local subdir="$4"

  find "$ROOT/$subdir" -type f -name "*.nix" ! -name "default.nix" | sort | while read -r f; do
    module="$(basename "$f" .nix)"
    {
    #  [[ "$with_headers" == "yes" ]] && extract_module_description "$f"
      [[ "$with_headers" == "yes" ]] && extract_header "$f"
      echo "      ${module} = {"
      extract_options "$f" "$with_comments" | sed 's/^/        /'
      echo "      };"
      echo
    } >> "$base"
  done
}

# --- Process each section in order ---
for section in "system" "home" "hardware"; do
  for f in "$OUT1" "$OUT2" "$OUT3" "$OUT4"; do
    echo "    ${section} = {" >> "$f"
  done

  append_modules "$OUT1" yes yes "${section^}"
  append_modules "$OUT2" yes no  "${section^}"
  append_modules "$OUT3" no  yes "${section^}"
  append_modules "$OUT4" no  no  "${section^}"

  for f in "$OUT1" "$OUT2" "$OUT3" "$OUT4"; do
    echo "    };" >> "$f"
    echo >> "$f"
  done
done

# --- Finish all files ---
for f in "$OUT1" "$OUT2" "$OUT3" "$OUT4"; do
  write_epilog "$f"
done

echo "Wrote:"
echo " - $OUT1"
echo " - $OUT2"
echo " - $OUT3"
echo " - $OUT4"




# a
