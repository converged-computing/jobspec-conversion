#!/bin/bash
#SBATCH --job-name=horovod_multiGPU_demo
#SBATCH --output=%x-%j-slurm.out
#SBATCH --error=%x-%j-slurm.err
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=00:10:00
#SBATCH --partition=batch

export OMPI_MCA_btl='^openib'
export IMAGE='$PWD/horovod_gpu_0192.sif'
export OMP_NUM_THREADS='1'

module load rl9-gpustack
module load openmpi/4.1.4/gnu11.2.1-cuda11.8
module load singularity
export OMPI_MCA_btl=^openib
export IMAGE=$PWD/horovod_gpu_0192.sif
export OMP_NUM_THREADS=1
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
echo "Node IDs of participating nodes ${nodes_array[*]}"
echo "Tensorflow2 with Horovod"
mpirun -np 4 -N 2 singularity exec --nv $IMAGE python ./tensorflow2_synthetic_benchmark.py --model ResNet50  --batch-size 128 --num-warmup-batches 10 --num-batches-per-iter 10 --num-iters 10 >> TF2_multiGPU.log
echo "PyTorch with Horovod"
mpirun -np 4 -N 2 singularity exec --nv $IMAGE python ./pytorch_synthetic_benchmark.py --model resnet50 --batch-size 128 --num-warmup-batches 10 --num-batches-per-iter 10 --num-iters 10 >>pytorch_multiGPU.log
