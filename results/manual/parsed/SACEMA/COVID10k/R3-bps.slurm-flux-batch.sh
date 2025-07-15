#!/bin/bash
#FLUX: --job-name=covid10k-bpsamples-R3
#FLUX: --urgency=16

module load R/3.6.3
tar=$(tail -n+$SLURM ARRAY_TASK_ID R3.txt | head -n1)
make $tar
