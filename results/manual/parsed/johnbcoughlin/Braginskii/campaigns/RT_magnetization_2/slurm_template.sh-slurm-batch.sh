#!/bin/bash
#SBATCH --job-name=RT-magnetization-2
#SBATCH --account=amath
#SBATCH --output=@@WORKDIR@@/sims/RT-%a/sim.log
#SBATCH --error=@@WORKDIR@@/sims/RT-%a/sim.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=2-00:00:00
#SBATCH --partition=ckpt
#SBATCH --chdir=@@WORKDIR@@
#SBATCH --array=1-@@NTASKS@@%6

export OPENBLAS_NUM_THREADS='1'

module use ~/modulefiles
module load julia
export OPENBLAS_NUM_THREADS=1
julia --version
julia --project=../.. --startup-file=no main.jl --run $SLURM_ARRAY_TASK_ID
