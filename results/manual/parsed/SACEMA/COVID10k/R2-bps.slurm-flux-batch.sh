#!/bin/bash
#FLUX: --job-name=covid10k-bpsamples-R2
#FLUX: -t=3600
#FLUX: --urgency=16

module load R/3.6.3
tar=$(tail -n+$SLURM_ARRAY_TASK_ID R2.txt | head -n1)
make $tar
