#!/bin/bash
set -e

echo "=== Patching BusyBox config for sha256sum ==="

# Ищем все потенциальные конфиги BusyBox в padavan-ng
CONFIGS=$(find padavan-ng/trunk -path "*busybox*" \
    \( -name ".config" -o -name "busybox.config" -o -name "*busybox*config*" \) \
    2>/dev/null || true)

if [[ -z "$CONFIGS" ]]; then
    echo ">>> No BusyBox configs found, checking configs/ dir..."
    CONFIGS=$(find padavan-ng/trunk/configs -name "*busybox*" 2>/dev/null || true)
fi

echo ">>> Found configs:"
echo "$CONFIGS"

for cfg in $CONFIGS; do
    echo ">>> Patching: $cfg"

    # Включаем sha256sum
    sed -i 's/^# CONFIG_SHA256SUM is not set/CONFIG_SHA256SUM=y/' "$cfg"
    sed -i 's/^CONFIG_SHA256SUM=.*/CONFIG_SHA256SUM=y/' "$cfg"

    # Если строки не было вовсе — добавляем
    if ! grep -q '^CONFIG_SHA256SUM=' "$cfg"; then
        echo 'CONFIG_SHA256SUM=y' >> "$cfg"
    fi

    # На всякий случай включаем и остальные хеши
    for h in MD5SUM SHA1SUM SHA512SUM FEATURE_MD5_SHA1_SUM_CHECK; do
        sed -i "s/^# CONFIG_${h} is not set/CONFIG_${h}=y/" "$cfg"
        sed -i "s/^CONFIG_${h}=.*/CONFIG_${h}=y/" "$cfg"
    done
done

echo "=== Done patching BusyBox configs ==="
