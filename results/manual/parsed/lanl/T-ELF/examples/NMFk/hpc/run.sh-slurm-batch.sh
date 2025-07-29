#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=120
#SBATCH --time=00:30:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

export PMIX_MCA_gds='hash'
export n_jobs='$SLURM_CPUS_PER_TASK'

export PMIX_MCA_gds=hash
source activate TELF
echo $CONDA_DEFAULT_ENV
export n_jobs=$SLURM_CPUS_PER_TASK
export PMIX_MCA_gds=hash
mpirun -n 2 python example.py 
