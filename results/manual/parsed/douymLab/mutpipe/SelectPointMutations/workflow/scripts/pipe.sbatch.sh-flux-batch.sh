#!/bin/bash
#FLUX: --job-name=bumfuzzled-destiny-6210
#FLUX: --priority=16

import socket
set +u
module load gcc;
module load jdk/11.0.10;
source /home/douyanmeiLab/lujinhong/miniconda3/etc/profile.d/conda.sh
set -u
snakemake --unlock --cores 4
snakemake --rerun-incomplete -j 190 --restart-times 3 --latency-wait 120 --keep-going --cluster "sbatch -p intel-e5,amd-ep2 -q normal -c 1 -o /storage/douyanmeiLab/lujinhong/logs/22_4_16/LZ_filter/%x_%J_out.txt "
