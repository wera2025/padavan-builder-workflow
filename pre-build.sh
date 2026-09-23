#!/bin/bash
# Включаем sha256sum в BusyBox Padavan

# Ищем любой существующий конфиг BusyBox
CFG=$(find padavan-ng/trunk/user/busybox -maxdepth 2 -name ".config" -o -name "busybox.config" | head -n1)

if [ -z "$CFG" ]; then
    echo "Конфиг BusyBox не найден, создаём пустой и включаем sha256sum"
    CFG="padavan-ng/trunk/user/busybox/busybox.config"
    touch "$CFG"
fi

# Включаем нужные опции
if grep -q "CONFIG_SHA256SUM" "$CFG"; then
    sed -i 's/^# CONFIG_SHA256SUM is not set/CONFIG_SHA256SUM=y/' "$CFG"
    sed -i 's/^CONFIG_SHA256SUM=n/CONFIG_SHA256SUM=y/' "$CFG"
else
    echo "CONFIG_SHA256SUM=y" >> "$CFG"
fi

echo "sha256sum включён в $CFG"
cat "$CFG" | grep SHA256
