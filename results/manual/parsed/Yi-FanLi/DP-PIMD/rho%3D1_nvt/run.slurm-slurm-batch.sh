#!/bin/bash
#SBATCH --job-name=lj-nvt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=01:00:00

export PATH='$LAMMPS_DIR:$PATH'
export OMP_NUM_THREADS='1'

LAMMPS_DIR=/scratch/gpfs/yifanl/Softwares/lammps/build
export PATH=$LAMMPS_DIR:$PATH
export OMP_NUM_THREADS=1
module purge
module load openmpi/gcc/3.1.5/64
mpirun -np 4 lmp -p 4x1 -in in.lj_nvt -log log -screen screen
