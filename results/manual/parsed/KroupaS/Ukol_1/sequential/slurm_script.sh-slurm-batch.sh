#!/bin/bash
#SBATCH --job-name=my_mpi_program
#SBATCH --output=slurm_out/%x-%J.out
#SBATCH --error=slurm_out%x-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

source /etc/profile.d/zz-cray-pe.sh
srun ./vps.out in_0001.txt -s 1
exit 0
