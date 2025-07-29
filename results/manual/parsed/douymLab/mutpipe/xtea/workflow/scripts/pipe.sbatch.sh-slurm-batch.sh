#!/bin/bash
#FLUX: --job-name=xtea
#FLUX: --queue=normal
#FLUX: --urgency=16

import socket
set +u
source /home/douyanmeiLab/lujinhong/miniconda3/etc/profile.d/conda.sh
conda activate mutpipe_xtea
set -u
snakemake --unlock --cores 4
snakemake --rerun-incomplete -j 400 --restart-times 3 --latency-wait 120 --cluster "sbatch -p amd-ep2,intel-e5 -q huge -c 1 -t 48:00:00 --mem=8000M -o /storage/douyanmeiLab/lujinhong/logs/22_4_9/LZ_strelka/%x_%J_out.txt "
