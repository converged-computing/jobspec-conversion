#!/bin/bash
#FLUX: --job-name=simple_job
#FLUX: -n=4
#FLUX: -t=1200
#FLUX: --urgency=16

module load gcc/8.2.0 python/3.9.9 cmake/3.25.0 freeglut/3.0.0 libxrandr/1.5.0  libxinerama/1.1.3 libxi/1.7.6  libxcursor/1.1.14 mesa/17.2.3 eth_proxy
xvfb-run -a --server-args="-screen 0 480x480x24" python3 src/python/main.py
