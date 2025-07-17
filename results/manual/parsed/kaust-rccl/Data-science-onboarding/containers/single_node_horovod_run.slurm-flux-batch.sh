#!/bin/bash
#FLUX: --job-name=muffled-bike-5678
#FLUX: -n=4
#FLUX: -c=8
#FLUX: -t=1800
#FLUX: --urgency=16

export IMAGE='$PWD/horovod.sif'

module load rl9-gpustack
module load openmpi/4.1.4/gnu11.2.1-cuda11.8
module load singularity
export IMAGE=$PWD/horovod.sif
echo "Tensorflow2 with Horovod"
mpirun -np 4  singularity exec --nv $IMAGE python ./tensorflow2_synthetic_benchmark.py --model ResNet50  --batch-size 128 --num-warmup-batches 10 --num-batches-per-iter 10 --num-iters 10 >> TF2_1node.log
echo "PyTorch with Horovod"
singularity exec --nv $IMAGE horovodrun -np 4 -H localhost:4 python ./pytorch_synthetic_benchmark.py --model resnet50 --batch-size 128 --num-warmup-batches 10 --num-batches-per-iter 10 --num-iters 10 >>pytorch_1node.log
