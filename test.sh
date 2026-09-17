#!/usr/bin/env bash
set -euo pipefail

echo "Verifying that lc87.slaspec compiles"
/opt/ghidra/support/sleigh data/languages/lc87.slaspec build/lc87.sla
echo "Building extension"
gradle

extension_zip=""
for file in dist/*.zip; do
  [[ $file -nt $extension_zip ]] && extension_zip=$file
done

config_dir=""
for file in test-config/ghidra/ghidra_*/; do
  [[ $file -nt $config_dir ]] && config_dir=$file
done

if [ ! "$extension_zip" ]; then
    echo "ERROR: No extension zip found"
else
    echo "Extension: $extension_zip"
fi

if [ ! "$config_dir" ]; then
    echo "ERROR: No settings dir found"
else
    echo "Ghidra settings: $config_dir"
fi

if [ "$extension_zip" -a "$config_dir" ]; then
    # TODO: install extension
    echo "Installing extension"

    extensions_dir="$config_dir/Extensions/"
    rm -rf "$extensions_dir"
    mkdir -p "$extensions_dir"

    bsdtar -xf "$extension_zip" -C "$extensions_dir"
fi

project_file="$(realpath ../ghidra/wacom-firmware.gpr)"

GHIDRA_JAVA_OPTIONS="-Dapplication.settingsdir=$(realpath ./test-config) -DUSER_AGREEMENT=ACCEPT -DSHOW_TIPS=false -DGhidraShowWhatsNew=false" \
    /opt/ghidra/support/ghidraDebug "$project_file"

