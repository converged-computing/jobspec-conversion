#!/bin/bash
#FLUX: --job-name=babel_cuda
#FLUX: --queue=gpumedium
#FLUX: -t=120
#FLUX: --urgency=16

for i in {1..10}; do
        echo $i
        srun -n 1 ./cuda-stream;
        sleep 5;
done
