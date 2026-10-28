reset
set terminal png size 1000,1000
set output 'simulation.png'

# --- Titel und Achsenbeschriftungen auf Deutsch ---
set title "Sensor- und Labyrinth-Simulation"
set xlabel "X-Position"
set ylabel "Y-Position"
set size ratio -1       # Maßstab 1:1 (keine Verzerrung)
set grid
set xrange [0:16]
set yrange [0:16]
set key outside right top

# --- Stile für Linien und Punkte ---
set style line 1 lc rgb "#9400d3" lt 1 lw 0.6   # Sensorstrahlen (violett)
set style line 2 lc rgb "#2ca02c" lt 1 lw 2.5   # Wände (grün)
set style line 3 lc rgb "#00C853" pt 7 ps 2.5   # Roboter (großer grüner Punkt)

# --- Zeichnen mit deutschen Legendenbeschriftungen ---
plot \
    'Sensor.txt' using 1:2:($3-$1):($4-$2) with vectors nohead ls 1 title "Sensorstrahlen", \
    'Sensor.txt' using 3:4 with points pt 7 ps 0.5 lc rgb "#D50000" title "Trefferpunkte", \
    'Labyrinth.txt' using 1:2:($3-$1):($4-$2) with vectors nohead ls 2 title "Waende", \
    'Sensor.txt' every ::0::0 using 1:2 with points ls 3 title "Roboter"