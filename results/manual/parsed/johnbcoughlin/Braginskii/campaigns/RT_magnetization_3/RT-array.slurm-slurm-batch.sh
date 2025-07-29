#!/bin/bash
#SBATCH --job-name=RT-magnetization-3
#SBATCH --account=amath
#SBATCH --output=/mmfs1/gscratch/aaplasma/johnbc/projects/Braginskii/campaigns/RT_magnetization_3//sims/RT-%a/sim.log
#SBATCH --error=/mmfs1/gscratch/aaplasma/johnbc/projects/Braginskii/campaigns/RT_magnetization_3//sims/RT-%a/sim.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=5-00:00:00
#SBATCH --partition=gpu-rtx6k
#SBATCH --chdir=/mmfs1/gscratch/aaplasma/johnbc/projects/Braginskii/campaigns/RT_magnetization_3/
#SBATCH --array=1-6%2

export OPENBLAS_NUM_THREADS='1'

module use ~/modulefiles
module load julia
export OPENBLAS_NUM_THREADS=1
julia --version
julia --project=../.. --startup-file=no main.jl --run $SLURM_ARRAY_TASK_ID
