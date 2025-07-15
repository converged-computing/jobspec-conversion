#!/bin/bash
#FLUX: --job-name=bricky-pot-2924
#FLUX: --priority=16

cd /users/amaesumi/pack_poly
module load anaconda/2022.05
module load gcc/10.2
source /gpfs/runtime/opt/anaconda/2020.02/etc/profile.d/conda.sh
conda activate systems
NUM_THREADS=32
python stability.py --stage preproc --nthreads $NUM_THREADS --thread_id $SLURM_ARRAY_TASK_ID
