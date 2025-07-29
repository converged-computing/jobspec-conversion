#!/bin/bash
#SBATCH --account=def-mgoubran
#SBATCH --output=/home/rozakmat/projects/rrg-bojana/rozakmat/TBI_monai_UNET/logs/center-%A_%a.out
#SBATCH --mail-user=matthew.rozak@mail.utoronto.ca
#SBATCH --mail-type=REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6GB
#SBATCH --time=03:00:00
#SBATCH --array=0-30%20
#SBATCH --dependency=17035229

module load matlab
matlab -nodisplay -nodesktop -r "gen_skeletons_warped_single_matt"
