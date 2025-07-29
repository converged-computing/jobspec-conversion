#!/bin/bash
#SBATCH --job-name=s_chromatin
#SBATCH --output=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_chromatin.out
#SBATCH --error=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_chromatin.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --partition=hbfraser,hns,normal

module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/chromatin/
snakemake --restart-times 1 --nolock --printshellcmds --keep-going --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
