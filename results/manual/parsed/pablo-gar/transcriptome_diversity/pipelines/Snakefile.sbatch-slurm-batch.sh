#!/bin/bash
#SBATCH --output=/scratch/users/paedugar/transcriptome_diversity/cluster_files/1_trans_diversity.out
#SBATCH --error=/scratch/users/paedugar/transcriptome_diversity/cluster_files/1_trans_diversity.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=12:00:00

module load conda
conda activate base
cd ~/scripts/FraserLab/transcriptome_diveristy/pipelines/
snakemake --nolock --printshellcmds --keep-going --cluster-config ../cluster.json --cluster-status jobState --jobs 500 --cluster "../submit.py" --snakefile  Snakefile_main.smk
