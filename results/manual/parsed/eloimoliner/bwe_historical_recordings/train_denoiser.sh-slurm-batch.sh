#!/bin/bash
#FLUX: --job-name=training_array_metrics
#FLUX: -c=10
#FLUX: -t=259199
#FLUX: --urgency=16

module load anaconda 
source activate /scratch/work/molinee2/conda_envs/2022_torchot
n=$SLURM_ARRAY_TASK_ID
n=3
iteration=`sed -n "${n} p" iteration_parameters_denoiser.txt`      # Get n-th line (2-indexed) of the file
PATH_EXPERIMENT=experiments_denoiser/${n}
mkdir $PATH_EXPERIMENT
python  train_denoiser.py path_experiment="$PATH_EXPERIMENT" $iteration  epochs=150  num_workers=10
