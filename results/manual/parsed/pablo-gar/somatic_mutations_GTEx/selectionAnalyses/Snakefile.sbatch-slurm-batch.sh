#!/bin/bash
#SBATCH --job-name=s_selection
#SBATCH --output=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_selection.out
#SBATCH --error=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_selection.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00

module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/selectionAnalyses/
snakemake --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --cluster-config ../cluster.json --cluster-status jobState --jobs 1000 --keep-going --cluster "../submit.py"
