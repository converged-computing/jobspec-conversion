#!/bin/bash
#FLUX: --job-name=astute-lamp-1507
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --urgency=16

export SLURM_ARRAY_TASK_ID='$(($SLURM_ARRAY_TASK_ID+1))'
export index='$i'

module load pytorch-gpu/py3/1.8.0
exp=$1
i=$2
export SLURM_ARRAY_TASK_ID=$(($SLURM_ARRAY_TASK_ID+1))
line=$(sed "${SLURM_ARRAY_TASK_ID}q;d" base_filenames_test.txt)
export index=$i
seed=$(shuf -n 1 $SCRATCH/data/seeds_${index})
./script_generate.sh $exp $line --generate_bvh --data_dir $SCRATCH/data/dance_combined_test${i} --output_folder=inference/generated_${i} --seeds expmap_scaled_20,$seed
