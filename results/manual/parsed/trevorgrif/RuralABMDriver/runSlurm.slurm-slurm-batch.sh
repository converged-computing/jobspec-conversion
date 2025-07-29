#!/bin/bash
#SBATCH --job-name=ABM
#SBATCH --mail-user=EMAIL
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=100G
#SBATCH --constraint=ceph

. /usr/modules/init/bash
module load julia
cd $SLURM_SUBMIT_DIR
julia -t 32 -p 32 -L distributed_startup.jl $FILE
