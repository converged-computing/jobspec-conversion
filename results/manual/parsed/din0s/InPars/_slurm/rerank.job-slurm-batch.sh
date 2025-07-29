#!/bin/bash
#SBATCH --job-name=RerankInPars
#SBATCH --output=slurm_rerank_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gres=gpu:1
#SBATCH --mem=120gb
#SBATCH --time=04:00:00
#SBATCH --partition=gpu
#SBATCH --array=1-4%4

module purge
module load 2022
module load Anaconda3/2022.05
source activate thesis
cd $HOME/InPars
mkdir -p runs
CHUNK_IDX=$((SLURM_ARRAY_TASK_ID - 1))
python -u \
    -m inpars.rerank \
    --model ./models/arguana/ \
    --dataset arguana \
    --chunk_queries $SLURM_ARRAY_TASK_MAX \
    --chunk_idx $CHUNK_IDX \
    --output_run ./runs/arguana_$CHUNK_IDX.txt \
    --batch_size 128 \
    --bf16
