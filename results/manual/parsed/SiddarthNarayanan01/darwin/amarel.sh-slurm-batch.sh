#!/bin/bash
#FLUX: --job-name=darwin
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

export OLLAMA_DEBUG='1'
export OLLAMA_NUM_PARALLEL='4'
export OLLAMA_MAX_LOADED='4'
export OLLAMA_HOST='0.0.0.0'
export BASE_LOG_PATH='/scratch/$USER/JOB-$SLURM_JOB_ID/'

module purge
module load cuda/12.1.0
cd $HOME/darwin
export OLLAMA_DEBUG=1
export OLLAMA_NUM_PARALLEL=4
export OLLAMA_MAX_LOADED=4
export OLLAMA_HOST="0.0.0.0"
export BASE_LOG_PATH="/scratch/$USER/JOB-$SLURM_JOB_ID/"
srun --overlap -n1 ollama serve &
srun --overlap -n1 python3 run.py &
wait
