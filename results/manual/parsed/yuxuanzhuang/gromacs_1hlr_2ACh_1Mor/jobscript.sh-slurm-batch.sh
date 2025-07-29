#!/bin/bash
#SBATCH --job-name=jobname
#SBATCH --output=job-%j.out
#SBATCH --error=job-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu

module unload gromacs
module switch gromacs/2023 gromacs=gmx_mpi
module switch cuda/11.8
module unload openmpi
module load openmpi
srun -n 4 gmx_mpi mdrun -deffnm md -cpi md -multidir rep1 rep2 rep3 rep4 -ntomp $((SLURM_JOB_CPUS_PER_NODE/4)) -maxh 23
