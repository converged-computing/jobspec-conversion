#!/bin/bash
#SBATCH --job-name=matlab-svd
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:02:00

module purge
module load matlab/R2021b
matlab -singleCompThread -nodisplay -nosplash -r svd
