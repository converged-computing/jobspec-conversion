#!/bin/bash
#FLUX: --job-name=purple-latke-7538
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=360000
#FLUX: --urgency=16

module purge
module load parabricks/3.1.1 singularity/3.5.1 cuda/10.1
cd /mnt/rds/txl80/LaframboiseLab/vst14/AR_BAM/
bash /mnt/rds/txl80/LaframboiseLab/vst14/pbtest_DB.sh
