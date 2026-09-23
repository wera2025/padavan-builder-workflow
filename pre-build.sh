#!/bin/bash
# Проверяем, существует ли конфигурационный файл BusyBox (он появляется после клонирования исходного кода)
BB_CONFIG="padavan-ng/trunk/user/busybox/busybox-1.37.0/.config"

if [[ -f "$BB_CONFIG" ]]; then
    # Принудительно включаем sha256sum
    sed -i 's/^# CONFIG_SHA256SUM is not set/CONFIG_SHA256SUM=y/' "$BB_CONFIG"
    sed -i 's/^CONFIG_SHA256SUM=.*/CONFIG_SHA256SUM=y/' "$BB_CONFIG"
    echo "Patched BusyBox config for sha256sum"
else
    echo "BusyBox .config not found yet, skipping patch"
fi
