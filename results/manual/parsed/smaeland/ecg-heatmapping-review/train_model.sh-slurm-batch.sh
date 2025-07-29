#!/bin/bash
#SBATCH --job-name=train-ecg
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=08:00:00
#SBATCH --partition=dgx2q

echo "Loading modules"
module use /cm/shared/ex3-modules/latest/modulefiles
module load slurm/20.02.7
module load pytorch-py37-cuda11.2-gcc8/1.9.1
if [ ! -f /usr/lib/x86_64-linux-gnu/libevent_core-2.1.so.6 ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/lib
fi
srun python train_medians.py -t qt -o stevennet_take5_x
