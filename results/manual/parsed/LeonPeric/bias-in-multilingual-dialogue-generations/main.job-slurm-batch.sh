#!/bin/bash
#SBATCH --job-name=runATCS
#SBATCH --output=slurm_output_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gres=2
#SBATCH --mem=64000M
#SBATCH --time=1-11:59:00

module purge
module load 2022
module load Anaconda3/2022.05
cd $TMPDIR/bias-in-multilingual-dialogue-generations/
source activate dl2023
model_name='LLama'
max_new_tokens=512
temperature=0.0
sequences_amount=1
batch_size=1
language="English"
python run.py \
    --model_name $model_name\
    --max_new_tokens $max_new_tokens\
    --temperature $temperature\
    --sequences_amount $sequences_amount\
    --batch_size $batch_size\
    --language $language\
