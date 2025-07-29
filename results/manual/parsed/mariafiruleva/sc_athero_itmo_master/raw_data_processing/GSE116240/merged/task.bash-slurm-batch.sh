#!/bin/bash
#SBATCH --job-name=GSE116240
#SBATCH --output=pipeline.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=80G
#SBATCH --time=1-00:00:00
#SBATCH --qos=1

sbatch << ENDINPUT
cd /mnt/tank/scratch/mfiruleva/scn/data/GSE116240/merged
snakemake -j 4 --use-singularity --use-conda --conda-prefix /mnt/tank/scratch/mfiruleva/scn/config --singularity-prefix /mnt/tank/scratch/mfiruleva/scn/config --singularity-args '--bind /mnt/tank/scratch/mfiruleva/scn/config/5d179225:/mnt/tank/scratch/mfiruleva/scn/config/5d179225 --bind /mnt/tank/scratch/mfiruleva/scn/data/GSE116240:/mnt/tank/scratch/mfiruleva/scn/data/GSE116240 --bind /mnt/tank/scratch/mfiruleva/scn/stats/summary.csv:/mnt/tank/scratch/mfiruleva/scn/stats/summary.csv' --verbose
ENDINPUT
