#!/bin/bash
#FLUX: --job-name=parallel
#FLUX: --queue=day
#FLUX: -t=3600
#FLUX: --priority=16

NUM_LIST=($(seq 0 1 5))
echo "rng seed = " ${NUM_LIST[${SLURM_ARRAY_TASK_ID}]}
module load miniconda
conda activate qram_fidelity
python expensive_job.py --N=1000 --r=${NUM_LIST[${SLURM_ARRAY_TASK_ID}]}
