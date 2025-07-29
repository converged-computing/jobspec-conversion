#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --time=00:10:00
#SBATCH --partition=rome
#SBATCH: --exclusive

module load 2022
module load GROMACS/2021.6-foss-2022a
THREADS=48
setenv GMX_MAXCONSTRWARN -1
srun gmx_mpi mdrun -deffnm step7_production -pin on -g two_nodes.log
