#!/bin/bash
#SBATCH --output=sbExample.%j.out
#SBATCH --error=sbExample.%j.err
#SBATCH --nodes=6
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=ib
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=2

srun bash -c 'KERAS_BACKEND=tensorflow CUDA_VISIBLE_DEVICES=-1 MKL_NUM_THREADS=4 OPENBLAS_NUM_THREADS=4 /mnt/xfs1/home/agiovann/anaconda3/envs/caiman_dev/bin/python /mnt/xfs1/home/agiovann/SOFTWARE/CaImAn/use_cases/CaImAnpaper/online_testing2_bk_slurm.py $SLURM_PROCID' 
