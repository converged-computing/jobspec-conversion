#!/bin/bash
#FLUX: --job-name=babel_hipsycl
#FLUX: --queue=gpumedium
#FLUX: -t=120
#FLUX: --urgency=16

for i in {1..10}; do
        echo $i
        srun -n 1 ./sycl-stream --device 1;
        sleep 5;
done
