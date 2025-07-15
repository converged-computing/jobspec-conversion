#!/bin/bash
#FLUX: --job-name=example1
#FLUX: -t=600
#FLUX: --priority=16

module load vis/gnuplot
python example1.py
gnuplot gnuplot/time_vs_array_size.gpi
