#!/bin/bash
#FLUX: --job-name=test_simulation
#FLUX: -c=4
#FLUX: --queue=short
#FLUX: -t=2400
#FLUX: --urgency=16

cd $SCRATCH
module load Anaconda3/2022.05
module load PyTorch/1.11.0-foss-2021a-CUDA-11.3.1
module load tqdm/4.61.2-GCCcore-10.3.0
rsync $DATA/main.py ./
rsync $DATA/simulation.py ./
config=$DATA/config.txt
n_neurons=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
max_time=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
n_paths=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
python -u main.py --n_neurons ${n_neurons} --max_time ${max_time} --n_paths ${n_paths} --no_rolling_mean --return_summary=True --discard_history > output.out
