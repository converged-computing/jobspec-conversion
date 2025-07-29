#!/bin/bash
#SBATCH --job-name=my-matlab
#SBATCH --mail-user=<YourNetID>@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:01:00
#SBATCH --partition=hpc

module purge
module load matlab
module list
srun matlab -singleCompThread -nodisplay -nosplash -nojvm -r hello_world
