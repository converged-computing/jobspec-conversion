#!/bin/bash
#FLUX: --job-name=gloopy-animal-6762
#FLUX: --priority=16

set +u
module load gcc
module load jdk/11.0.10
source /home/douyanmeiLab/lujinhong/miniconda3/etc/profile.d/conda.sh
set -u
snakemake --unlock --cores 4
snakemake --rerun-incomplete -j 1200 --rerun-incomplete --restart-times 3 --latency-wait 120 --keep-going --cluster "sbatch -p amd-ep2,intel-e5 -q huge -c 1  --mem=12000 -o /storage/douyanmeiLab/lujinhong/logs/22_4_18/LZ_MSIprofiler/%x_%J_out.txt"
