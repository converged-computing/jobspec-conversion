#!/bin/bash
#SBATCH --output=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_methodValidation.out
#SBATCH --error=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_methodValidation.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=12:00:00

module load anaconda3
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/methodValidation/
date
echo "Start snakemake"
snakemake --nolock --restart-times 1 --keep-going --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
date
echo "Snakemake done!"
