#!/bin/bash
#FLUX: --job-name=gmrt_cnn
#FLUX: --queue=gpuq
#FLUX: -t=18000
#FLUX: --priority=16

module load use.own
module load broadwell gcc/5.4.0 cuda python magma cffi
source /group/pawsey0245/kvinsen/pytorch/bin/activate
cd /group/pawsey0245/kvinsen/rfi_ml/src
srun -n 1 python -m cProfile -o train_gmrt_cnn.prof train_gmrt_cnn.py --use-gpu --save gmrt_cnn.model.saved --epochs 4 --batch-size 100000
