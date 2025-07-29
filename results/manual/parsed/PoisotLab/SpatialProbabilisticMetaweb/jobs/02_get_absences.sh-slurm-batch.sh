#!/bin/bash
#SBATCH --job-name=02_get_absences
#SBATCH --account=ctb-tpoisot
#SBATCH --output=jobs/out/%x-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=248G
#SBATCH --time=08:00:00
#SBATCH --array=1-3

module load StdEnv/2020
module load julia/1.9.1
cd $HOME/projects/def-tpoisot/2022-SpatialProbabilisticMetaweb/
julia --project --threads=63 -e 'JOBARRAY = true; CAN = true; quiet = true; include("02_get_absences.jl")'
