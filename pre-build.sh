#!/bin/bash
set -e

echo "=== Patching BusyBox config for sha256sum ==="

# Путь к конфигу BusyBox
BB_DIR="padavan-ng/trunk/user/busybox/busybox-1.37.0"
BB_CONFIG="$BB_DIR/.config"

if [[ ! -f "$BB_CONFIG" ]]; then
    echo ">>> .config not found, will be generated. Creating stub patch."

    # Если .config ещё нет — возможно, Padavan использует шаблон
    # Проверяем наличие базового шаблона в configs/
    find padavan-ng/trunk/user/busybox -name "*.config" -o -name "config.*" 2>/dev/null | while read f; do
        echo "Found: $f"
    done

    # Патчим шаблон Padavan, если он есть
    BB_TEMPLATE="padavan-ng/trunk/configs/busybox/busybox.config"
    if [[ -f "$BB_TEMPLATE" ]]; then
        sed -i 's/^# CONFIG_SHA256SUM is not set/CONFIG_SHA256SUM=y/' "$BB_TEMPLATE"
        sed -i 's/^CONFIG_SHA256SUM=.*/CONFIG_SHA256SUM=y/' "$BB_TEMPLATE"
        echo ">>> Patched template: $BB_TEMPLATE"
    fi
else
    # Если .config уже есть — правим его
    sed -i 's/^# CONFIG_SHA256SUM is not set/CONFIG_SHA256SUM=y/' "$BB_CONFIG"
    sed -i 's/^CONFIG_SHA256SUM=.*/CONFIG_SHA256SUM=y/' "$BB_CONFIG"

    # Убеждаемся, что строка присутствует, даже если её не было вовсе
    grep -q '^CONFIG_SHA256SUM=y' "$BB_CONFIG" || echo 'CONFIG_SHA256SUM=y' >> "$BB_CONFIG"

    echo ">>> Patched: $BB_CONFIG"
    grep -E '^CONFIG_(MD5|SHA1|SHA256|SHA512|SHA3)SUM' "$BB_CONFIG" || true
fi

echo "=== Done ==="
