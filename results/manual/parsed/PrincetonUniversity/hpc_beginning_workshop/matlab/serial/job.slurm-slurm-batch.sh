#!/bin/bash
#SBATCH --job-name=matlab
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:01:00

module purge
module load matlab/R2019a
matlab -singleCompThread -nodisplay -nosplash -nojvm -r hello_world
