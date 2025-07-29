#!/bin/bash
#SBATCH --account=skunkworks
#SBATCH --output=matlab-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --qos=skunkworks_owner

module load matlab/r2019b
matlab -nodisplay -r "run('spheres_placing3.m')"
