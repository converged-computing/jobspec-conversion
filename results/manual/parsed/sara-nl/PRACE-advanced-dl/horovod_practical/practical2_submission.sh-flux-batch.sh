#!/bin/bash
#FLUX: --job-name=goodbye-signal-3397
#FLUX: --urgency=16

ulimit -a
module load Python/3.6.3-foss-2017b
source hdis/bin/activate
mpirun -np 16 --map-by ppr:1:socket:pe=16 python keras-cifar10-resnet.py
