#!/bin/bash
#SBATCH --job-name=epj_binding_1
#SBATCH --output=job-%j.out
#SBATCH --error=job-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=30G
#SBATCH --time=1-00:00:00
#SBATCH --partition=lindahl4

module unload gromacs
module switch gromacs/2023 gromacs=gmx_mpi
module switch cuda/11.8
module unload openmpi
module load openmpi
srun -n 8 gmx_mpi mdrun -deffnm awh -cpi awh -multidir rep{1..8} -pme gpu -bonded gpu -nb gpu -px awh_pullx -pf awh_pullf -maxh 23
