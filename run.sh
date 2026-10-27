#!/bin/bash
# 1. Programm kompilieren (mit Mathe-Bibliothek -lm)
gcc main.c -o main -lm

# 2. Programm ausführen (erzeugt Sensor.txt)
./main

# 3. Gnuplot ausführen (erzeugt das Bild)
gnuplot -e "set terminal png size 800,800; set output 'scan_plot.png'; set grid; set key outside; plot 'Sensor.txt' using 1:2:(\$3-\$1):(\$4-\$2) with vectors nohead title 'Sensorstrahlen', 'Labyrinth.txt' using 1:2:(\$3-\$1):(\$4-\$2) with vectors nohead title 'Waende'"
