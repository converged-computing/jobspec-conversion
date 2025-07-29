#!/bin/bash
#SBATCH --job-name=s_cancer
#SBATCH --output=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_cancer.out
#SBATCH --error=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_cancer.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=hbfraser,hns,normal,owners

module load anaconda3
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/cancer/
snakemake --nolock --printshellcmds --keep-going --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
