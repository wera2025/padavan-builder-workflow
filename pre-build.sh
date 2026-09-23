#!/bin/bash
# Включаем sha256sum для BusyBox через главный конфиг Padavan

BUILD_CONFIG="build.config"

if [ -f "$BUILD_CONFIG" ]; then
    # Удаляем возможные старые строки (на всякий случай)
    sed -i '/CONFIG_BUSYBOX_CONFIG_SHA256SUM/d' "$BUILD_CONFIG"
    # Добавляем новую
    echo "CONFIG_BUSYBOX_CONFIG_SHA256SUM=y" >> "$BUILD_CONFIG"
    echo "=== Проверка build.config ==="
    grep "SHA256SUM" "$BUILD_CONFIG"
else
    echo "ОШИБКА: build.config не найден!"
fi
