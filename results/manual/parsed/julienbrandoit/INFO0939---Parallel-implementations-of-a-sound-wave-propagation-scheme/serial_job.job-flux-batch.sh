#!/bin/bash
#FLUX: --job-name=SERIAL output
#FLUX: -t=300
#FLUX: --urgency=16

module load Info0939Tools
gcc SERIAL/fdtd.c -o bin/fdtd -lm -O3 
cd ./example_inputs/simple3d
srun ../../bin/fdtd param_3d.txt
