#!/bin/bash
echo "=== Makefile.local ==="
find padavan-ng/trunk/user/busybox -name "Makefile.local" -exec cat {} \;

echo "=== Все .config и defconfig ==="
find padavan-ng/trunk/user/busybox -name "*.config" -o -name ".config" -o -name "*defconfig*" 2>/dev/null

echo "=== SHA256SUM во всех конфигах ==="
grep -r "SHA256SUM" padavan-ng/trunk/user/busybox/ 2>/dev/null | grep -v "\.c:"
