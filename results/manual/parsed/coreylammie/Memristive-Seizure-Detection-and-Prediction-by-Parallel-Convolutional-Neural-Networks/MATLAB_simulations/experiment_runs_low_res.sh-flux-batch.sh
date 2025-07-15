#!/bin/bash
#FLUX: --job-name=JCU-CL-MATLAB_experiment_runs_low_res
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load matlab/R2019b
module load cuda/11.3.0
module load gnu8/8.4.0
module load mvapich2
matlab -nodisplay -nosplash -r experiment_runs_low_res
