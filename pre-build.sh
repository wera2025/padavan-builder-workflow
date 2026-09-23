#!/bin/bash

BUSYBOX_CONFIG="padavan-ng/trunk/user/busybox/busybox.config"

echo "=== Enabling sha256sum in BusyBox ==="

if [ -f "$BUSYBOX_CONFIG" ]; then
    # Удаляем старые строки, чтобы не было дублей
    sed -i '/CONFIG_SHA256SUM/d' "$BUSYBOX_CONFIG"
    sed -i '/CONFIG_FEATURE_MD5_SHA1_SUM_CHECK/d' "$BUSYBOX_CONFIG"

    # Включаем sha256sum и проверку контрольных сумм
    echo "CONFIG_SHA256SUM=y" >> "$BUSYBOX_CONFIG"
    echo "CONFIG_FEATURE_MD5_SHA1_SUM_CHECK=y" >> "$BUSYBOX_CONFIG"

    echo "=== Готово. Проверка: ==="
    grep -E "SHA256SUM|MD5_SHA1_SUM_CHECK" "$BUSYBOX_CONFIG"
else
    echo "!!! Не найден $BUSYBOX_CONFIG !!!"
    echo "Ищу конфиги BusyBox:"
    find padavan-ng/trunk/user/busybox -maxdepth 2 -type f -name "*.config" -o -name ".config"
fi
