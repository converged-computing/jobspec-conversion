#!/bin/bash
#SBATCH --job-name=s_seq_depth
#SBATCH --output=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_seq_depth.out
#SBATCH --error=/scratch/users/paedugar/somaticMutationsProject/clusterFiles/1_Snakemake_seq_depth.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=09:00:00
#SBATCH --partition=hbfraser

module load fraserconda
source activate fraserconda
cd ~/scripts/FraserLab/somaticMutationsProject/mappingMutationCalling_pipeline/
snakemake --keep-going --snakefile SnakefileSeqdepth.smk --max-jobs-per-second 3 --max-status-checks-per-second 0.016 --nolock --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py"
