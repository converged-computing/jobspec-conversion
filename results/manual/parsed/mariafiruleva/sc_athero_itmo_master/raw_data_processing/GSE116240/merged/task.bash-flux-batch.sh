#!/bin/bash
#FLUX: --job-name=GSE116240
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

sbatch << ENDINPUT
cd /mnt/tank/scratch/mfiruleva/scn/data/GSE116240/merged
snakemake -j 4 --use-singularity --use-conda --conda-prefix /mnt/tank/scratch/mfiruleva/scn/config --singularity-prefix /mnt/tank/scratch/mfiruleva/scn/config --singularity-args '--bind /mnt/tank/scratch/mfiruleva/scn/config/5d179225:/mnt/tank/scratch/mfiruleva/scn/config/5d179225 --bind /mnt/tank/scratch/mfiruleva/scn/data/GSE116240:/mnt/tank/scratch/mfiruleva/scn/data/GSE116240 --bind /mnt/tank/scratch/mfiruleva/scn/stats/summary.csv:/mnt/tank/scratch/mfiruleva/scn/stats/summary.csv' --verbose
ENDINPUT
