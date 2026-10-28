reset
set terminal png size 2000,1500
set output 'robot_plot.png'

# --- Optik & Achsen ---
set title "Kognitive Robotik - Labyrinth, Roboter und Sensorstrahlen"
set xlabel "X-Position (mm)"
set ylabel "Y-Position (mm)"
set size ratio -1
set xrange [0:1500]
set yrange [0:1500]
set grid
set key outside right top

# --- 1) ROBOTER-GEOMETRIE & POSITION ---
set datafile separator comma
stats 'Rob_Spur.txt' nooutput
N = int(STATS_records)

eval sprintf("stats 'Rob_Spur.txt' every ::%d::%d using 1:2 nooutput", N-1, N-1)
rx_raw = STATS_mean_x
ry_raw = STATS_mean_y

eval sprintf("stats 'Rob_Spur.txt' every ::%d::%d using 3 nooutput", N-1, N-1)
ph = STATS_mean

M  = 100      # Skalierung Labyrinth & Sensor (Meter zu mm)
R  = 10       # Skalierung Roboter-Spur
X0 = 0
Y0 = 0
L  = 50
W  = 50
WL = 10
C  = 12

rx = rx_raw*R + X0
ry = ry_raw*R + Y0

px(u,v) = rx + u*cos(ph) - v*sin(ph)
py(u,v) = ry + u*sin(ph) + v*cos(ph)

# Roboter-Chassis und Räder zeichnen
set object 1 polygon from px(L,W),py(L,W) to px(-L,W),py(-L,W) \
    to px(-L,-W),py(-L,-W) to px(L,-W),py(L,-W) to px(L,W),py(L,W) \
    fs empty border rgb 'black' lw 3 front

set arrow 1 from px(-WL,W),py(-WL,W)   to px(WL,W),py(WL,W)   nohead lc rgb 'red'   lw 5 front
set arrow 2 from px(-WL,-W),py(-WL,-W) to px(WL,-W),py(WL,-W) nohead lc rgb 'red'   lw 5 front
set arrow 3 from px(-C,-C),py(-C,-C)   to px(C,C),py(C,C)     nohead lc rgb 'black' lw 2 front
set arrow 4 from px(-C,C),py(-C,C)     to px(C,-C),py(C,-C)   nohead lc rgb 'black' lw 2 front

# --- 2) FAHRSPUR ZEICHNEN (mit Komma-Trennzeichen) ---
set datafile separator comma
plot 'Rob_Spur.txt' using ($1*R+X0):($2*R+Y0) with lines lw 3 lc rgb '#76e04a' title 'Fahrspur', \
     1/0 with lines lw 3 lc rgb 'black' title 'Roboter', \
     1/0 with lines lw 3 lc rgb 'red'   title 'Raeder'

# --- 3) WÄNDE & LASER ZEICHNEN (Trennzeichen auf Leerzeichen zurückstellen) ---
unset datafile separator

# Wände aus Labyrinth.txt zeichnen (Dunkelblau)
replot 'Labyrinth.txt' using ($1*M):($2*M):(($3-$1)*M):(($4-$2)*M) \
        with vectors nohead lw 3 lc rgb 'navy' title 'Waende'

# Sensorstrahlen aus Sensor.txt zeichnen (Rot/Hellrot)
replot 'Sensor.txt' using ($1*M):($2*M):(($3-$1)*M):(($4-$2)*M) \
        with vectors nohead lw 1 lc rgb '#FA8072' title 'Sensorstrahlen'

        # --- Wände & Laser hinzufügen ---
unset datafile separator

replot 'Labyrinth.txt' using ($1*M):($2*M):(($3-$1)*M):(($4-$2)*M) \
        with vectors nohead lw 3 lc rgb 'navy' title 'Waende'

replot 'Sensor.txt' using ($1*M):($2*M):(($3-$1)*M):(($4-$2)*M) \
        with vectors nohead lw 1 lc rgb '#FA8072' title 'Sensorstrahlen'