#!/bin/bash
#FLUX: --job-name=covid10k-hosp-R3
#FLUX: --priority=16

module load R/3.6.3
tar=$(tail -n+$SLURM_ARRAY_TASK_ID hospR3.txt | head -n1)
make $tar
