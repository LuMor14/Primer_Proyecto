#!/bin/bash
echo "=== MONITOR DE RECURSOS DEL SISTEMA ==="

# Uso de CPU
echo -e "\n Uso de CPU:"
top -bn1 | grep "Cpu(s)" | awk '{print "Uso: " $2 "%"}'

# Memoria RAM libre
echo -e "\n Memoria libre:"
free -h | awk '/Mem/ {print "Disponible: " $4 " / Total: " $2}'

# Uso de disco
echo -e "\n Uso de disco:"
df -h | awk '$NF=="/"{print "Usado: " $5 " de " $2}'

# Estado de la batería (si es laptop)
if command -v upower &> /dev/null; then
    echo -e "\n Estado de la batería:"
    upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage"
fi

# Temperatura del CPU
if command -v sensors &> /dev/null; then
    echo -e "\n️ Temperatura del CPU:"
    sensors | grep 'Core' | awk '{print $1, $2, $3}'
else
    echo -e " No se encontró el comando 'sensors'. Instálalo con: sudo apt install lm-sensors"
fi

# Top 5 procesos por uso de CPU
echo -e " \nTop 5 procesos por uso de CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

# Top 5 procesos por uso de RAM
echo -e " \nTop 5 procesos por uso de RAM:"
ps -eo pid,comm,%mem --sort=-%mem | head -6


