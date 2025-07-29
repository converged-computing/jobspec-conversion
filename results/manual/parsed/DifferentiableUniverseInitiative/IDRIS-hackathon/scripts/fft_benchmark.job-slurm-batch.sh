#!/bin/bash
#SBATCH --job-name=fft_benchmark
#SBATCH --account=ftb@gpu
#SBATCH --output=fft_benchmark%j.out
#SBATCH --error=fft_benchmark%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=4

export TMPDIR='$JOBSCRATCH'

module purge
module load tensorflow-gpu/py3/2.4.1+nccl-2.8.3-1 nvidia-nsight-systems/2021.1.1
set -x
export TMPDIR=$JOBSCRATCH
ln -s $JOBSCRATCH /tmp/nvidia
srun --unbuffered --mpi=pmi2 -o fft_%t.log /gpfslocalsup/pub/idrtools/bind_gpu.sh nsys profile --stats=true -t nvtx,cuda,mpi -o result-%q{SLURM_TASK_PID} python -u fft_benchmark.py --mesh_shape="b1:2,b2:4" --layout="nx:b1,tny:b1,ny:b2,tnz:b2"
