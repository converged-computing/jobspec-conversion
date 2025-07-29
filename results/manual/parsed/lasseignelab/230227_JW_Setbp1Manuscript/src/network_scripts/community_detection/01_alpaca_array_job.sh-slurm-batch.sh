#!/bin/bash
#SBATCH --job-name=alpaca
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err
#SBATCH --mail-user=jbarham3@uab.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=255000
#SBATCH --time=02:00:00
#SBATCH --partition=express
#SBATCH --array=1-25

export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3'

module load R
module load Singularity/3.5.2-GCC-5.4.0-2.26
wd=/data/user/jbarham3/230227_JW_Setbp1Manuscript
export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3'
cd "${wd}"
file_pairs="${wd}/src/network_scripts/community_detection/file_pairs.txt"
line=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$file_pairs")
IFS=' ' read -r -a files <<< "$line"
file1="${files[0]}"
file2="${files[1]}"
folder_path="${wd}/results/PANDA"
echo "Folder path: $folder_path"
singularity exec --cleanenv --no-home -B "$wd" "$wd/bin/docker/setbp1_manuscript_1.0.6.sif" Rscript --vanilla "$wd/src/network_scripts/community_detection/01_alpaca_networks_array.R" "$file1" "$file2"
