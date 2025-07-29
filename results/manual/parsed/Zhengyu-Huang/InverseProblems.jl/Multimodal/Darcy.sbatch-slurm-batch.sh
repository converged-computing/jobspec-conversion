#!/bin/bash
#SBATCH --job-name=Darcy_call
#SBATCH --output=Darcy_calibration
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=1G
#SBATCH --time=7-00:00:00

export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'

module load julia/1.7.1
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
echo $JULIA_NUM_THREADS
julia GMKI_Darcy.jl |& tee gmki.Darcy.log
