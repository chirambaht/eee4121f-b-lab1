#!/usr/bin/env bash

h_speed=('1000' '100')
q_size=('100' '20')
congestion=('reno' 'cubic' 'bbr')

for speed in "${h_speed[@]}"; do
  for que in "${q_size[@]}"; do
    for cong in "${congestion[@]}"; do
      echo "Working with" $cong "at a host speed of" $speed "Mb/s and queue size of" $que
      sudo python tcp.py -B $speed -b 2 --delay 100 -d out/ --maxq $que --cong $cong
      sudo python plot_ping.py --files out/ping.txt --out "out/$speed $cong $que-ping.png"
      sudo python plot_queue.py --files out/q.txt --out "out/$speed $cong $que-queue.png"
    done
  done
done
