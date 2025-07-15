#!/bin/bash
#FLUX: --job-name=ornery-hippo-5831
#FLUX: --priority=16

module load Anaconda3/5.0.1-fasrc01
module load cuda/9.0-fasrc02 cudnn/7.4.1.5_cuda9.0-fasrc01
source activate tf1.12_cuda9
source sweeps/pacs_sweep/array_commands/${SLURM_ARRAY_TASK_ID}.sh
