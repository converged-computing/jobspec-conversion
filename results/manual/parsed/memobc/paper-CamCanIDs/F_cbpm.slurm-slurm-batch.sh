#!/bin/bash
#SBATCH --job-name=cbpm
#SBATCH --output=/mmfs1/scratch/kurkela/output/cbpm.out
#SBATCH --mail-user=kurkela@bc.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=4G
#SBATCH --time=00:50:00

cd /mmfs1/data/kurkela/Desktop/CamCan/code
module load matlab
matlab -nodisplay -nosplash -r "D_cbpm('memoryability', 'all', 'default', 0.01, 'none');"
