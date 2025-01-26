#!/bin/bash

# Renk değişiklikleri için bir fonksiyon tanımlıyoruz
set_color() {
    local r=$1
    local g=$2
    local b=$3
    local color=$(printf "%02X%02X%02X" $r $g $b)
    sudo bash -c "echo $color > /sys/devices/platform/hp-wmi/rgb_zones/zone00"
}

# Yumuşak renk geçişi için fonksiyon
fade_color() {
    local start_r=$1
    local start_g=$2
    local start_b=$3
    local end_r=$4
    local end_g=$5
    local end_b=$6
    local steps=200  # Daha fazla adım ekleyerek geçişi daha yumuşak yapıyoruz
    for ((i=0; i<=steps; i++)); do
        local r=$((start_r + (end_r - start_r) * i / steps))
        local g=$((start_g + (end_g - start_g) * i / steps))
        local b=$((start_b + (end_b - start_b) * i / steps))
        set_color $r $g $b
        sleep 0.01  # 10ms gecikme ile geçişi daha da yavaşlatıyoruz
    done
}

# Sonsuz renk döngüsü
while true; do
    fade_color 255 0 0   255 165 0   # Kırmızıdan turuncuya
    fade_color 255 165 0   0 255 0   # Turuncudan yeşile
    fade_color 0 255 0   0 0 255   # Yeşilden maviye
    fade_color 0 0 255   255 0 0   # Maviden kırmızıya
done
