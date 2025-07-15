#!/bin/bash
#FLUX: --job-name=babel_omp
#FLUX: --queue=gpumedium
#FLUX: -t=120
#FLUX: --priority=16

for i in {1..10}; do
        echo $i
        srun -n 1 ./omp-stream;
        sleep 5;
done
