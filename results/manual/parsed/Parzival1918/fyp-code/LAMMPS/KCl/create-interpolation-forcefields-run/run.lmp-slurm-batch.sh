#!/bin/bash
#SBATCH --job-name=system
#SBATCH --mail-user=pjuanroyo1@sheffield.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-06:00:00
#SBATCH --constraint=ntasks-per-node=64,ntasks-per-socket=32

export OMP_NUM_THREADS='1'

module purge
module load intel/2022b
export OMP_NUM_THREADS=1
srun --export=ALL --unbuffered --distribution=block:block --hint=nomultithread --exact \
/users/mta20pj/bin/lmp_stanage_03Mar2020_PLUMED -in input.lmp > screen.lmp
