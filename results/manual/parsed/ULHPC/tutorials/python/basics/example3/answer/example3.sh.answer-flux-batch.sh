#!/bin/bash
#FLUX: --job-name=example3
#FLUX: -t=600
#FLUX: --priority=16

module load vis/gnuplot
python example1.py
source numpy16/bin/activate
python example3.py
deactivate
gnuplot gnuplot/time_vs_array_size.gpi
