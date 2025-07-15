#!/bin/bash
#FLUX: --job-name=red-cattywampus-0138
#FLUX: --queue=fat
#FLUX: -t=1800
#FLUX: --urgency=16

module load 2021 Python/3.9.5-GCCcore-10.3.0 TensorFlow/2.6.0-foss-2021a-CUDA-11.3.1 
module load h5py/3.2.1-foss-2021a matplotlib/3.4.2-foss-2021a plotly.py/5.1.0-GCCcore-10.3.0 
sweep_file=./job_output/sweep_id-${SLURM_JOB_ID}.txt
wandb sweep $1 &> $sweep_file
sweep_id=`cat $sweep_file | grep agent | cut -d' ' -f8`
srun wandb agent $sweep_id
