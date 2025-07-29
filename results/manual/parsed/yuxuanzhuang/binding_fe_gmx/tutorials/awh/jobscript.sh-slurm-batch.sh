#!/bin/bash
#SBATCH --job-name=awh_epj
#SBATCH --output=job-%j.out
#SBATCH --error=job-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=1-00:00:00

module unload gromacs
module switch gromacs/2023 gromacs=gmx_mpi
module switch cuda/11.8
module unload openmpi
module load openmpi
cd AWH
srun -n 4 gmx_mpi mdrun -deffnm awh -cpi awh -multidir rep{1..4} -pme gpu -bonded gpu -nb gpu -px awh_pullx -pf awh_pullf -maxh 23
