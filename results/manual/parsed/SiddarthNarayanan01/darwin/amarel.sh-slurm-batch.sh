#!/bin/bash
#SBATCH --job-name=darwin
#SBATCH --output=/scratch/%u/JOB-%j/slurm-out.out
#SBATCH --error=/scratch/%u/JOB-%j/slurm-error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:3
#SBATCH --mem=100G
#SBATCH --time=02:00:00
#SBATCH --partition=gpu

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
