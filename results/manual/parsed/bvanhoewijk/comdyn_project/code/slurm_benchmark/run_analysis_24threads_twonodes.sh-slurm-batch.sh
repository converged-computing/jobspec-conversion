#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=rome
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=24

export OMP_NUM_THREADS='1'

module load 2022
module load GROMACS/2021.6-foss-2022a
THREADS=24
setenv GMX_MAXCONSTRWARN -1
export OMP_NUM_THREADS=1
srun gmx_mpi mdrun -deffnm step7_production -pin on -g two_nodes.log 
