#!/bin/bash
#SBATCH --job-name=mesh_nbody_benchmark
#SBATCH --account=ftb@gpu
#SBATCH --output=mesh_nbody_benchmark_%j.out
#SBATCH --error=mesh_nbody_benchmark_%j.out
#SBATCH --mail-user=denise.lanzieri@cea.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4
#SBATCH --time=00:15:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=4

export TMPDIR='$JOBSCRATCH'

module purge
module load tensorflow-gpu/py3/2.4.1+cuda-11.2 nvidia-nsight-systems/2021.1.1
set -x
export TMPDIR=$JOBSCRATCH
ln -s $JOBSCRATCH /tmp/nvidia
srun --unbuffered --mpi=pmi2 -o mesh_nbody_%t.log /gpfslocalsup/pub/idrtools/bind_gpu.sh nsys profile --stats=true -t nvtx,cuda,mpi -o result-%q{SLURM_TASK_PID} python -u mesh_nbody_benchmark.py  --nc=128 --batch_size=1 --nx=2 --ny=2 --hsize=32 --nsteps=3
