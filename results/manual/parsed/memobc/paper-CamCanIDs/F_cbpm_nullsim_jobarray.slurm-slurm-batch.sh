#!/bin/bash
#SBATCH --job-name=nullsim
#SBATCH --output=/mmfs1/scratch/kurkela/output/null_perms_%a.out
#SBATCH --mail-user=kurkela@bc.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=00:40:00
#SBATCH --array=1-100%10

cd /mmfs1/data/kurkela/Desktop/CamCan/code
module load matlab
matlab -nodisplay -nosplash -r "D_cbpm_nullsim('memoryability', 'all', 'default', 0.01, 'none', $SLURM_ARRAY_TASK_ID);"
