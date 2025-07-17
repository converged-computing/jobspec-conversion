#!/bin/bash
#FLUX: --job-name=milky-kitty-1430
#FLUX: -n=32
#FLUX: --queue=serial_requeue
#FLUX: -t=2400
#FLUX: --urgency=16

module load gcc/4.9.3-fasrc01 tensorflow/0.12.0-fasrc02
python fouriernetwork_odyssey64.py
