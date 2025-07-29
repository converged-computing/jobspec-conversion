#!/bin/bash
#SBATCH --job-name=run_lammps
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=cpu
#SBATCH --constraint=ntasks-per-node=40

module load oneapi/2021
KMP_BLOCKTIME=0 mpirun -n 80 singularity run $YOUR_IMAGE_PATH  lmp -i in.eam
