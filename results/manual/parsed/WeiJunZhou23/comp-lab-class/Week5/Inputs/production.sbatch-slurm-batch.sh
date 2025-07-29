#!/bin/bash
#SBATCH --job-name=gromacs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=04:00:00

module purge
module load gromacs/openmpi/intel/2018.3
srun -n 1 gmx_mpi grompp -f adp_T300.mdp -c adp.gro -p adp.top -o adp.tpr
srun -n 1 gmx_mpi mdrun -deffnm adp
