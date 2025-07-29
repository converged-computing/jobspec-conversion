#!/bin/bash
#SBATCH --account=slchen
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load nvidia/cuda/10.1
module load intel/parallelstudio/2017u8
/project/chenyongtin/tools/anaconda3/envs/deepmd-kit/bin/lmp -i in.lammps >lmp.out
