#!/bin/bash
#FLUX: --job-name=2_validate_and_select_best
#FLUX: -c=20
#FLUX: --queue=highmem
#FLUX: -t=2160000
#FLUX: --priority=16

module load samtools
module load R
module load pytorch/1.9.0py38-cuda
cd $SLURM_SUBMIT_DIR
bash 2_validate_and_select_best.sh $mdir $input
