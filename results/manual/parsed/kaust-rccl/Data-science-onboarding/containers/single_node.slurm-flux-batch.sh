#!/bin/bash
#FLUX: --job-name=horovod_demo
#FLUX: -n=4
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --priority=16

export IMAGE='$PWD/horovod.sif'

module load openmpi/4.1.4/gnu11.2.1-cuda11.8
module load singularity
export IMAGE=$PWD/horovod.sif
echo "PyTorch with Horovod"
mpirun -np 4  singularity exec --nv $IMAGE python ./pytorch_synthetic_benchmark.py --model resnet50 --batch-size 128 --num-warmup-batches 10 --num-batches-per-iter 10 --num-iters 10 >>pytorch_1node.log
echo "Tensorflow2 with Horovod"
mpirun -np 4  singularity exec --nv $IMAGE python ./tensorflow2_synthetic_benchmark.py --model ResNet50  --batch-size 128 --num-warmup-batches 10 --num-batches-per-iter 10 --num-iters 10 >> TF2_1node.log
