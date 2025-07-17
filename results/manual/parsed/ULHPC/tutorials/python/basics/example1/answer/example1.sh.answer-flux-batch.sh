#!/bin/bash
#FLUX: --job-name=example1
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

module load vis/gnuplot
python example1.py
gnuplot gnuplot/time_vs_array_size.gpi
