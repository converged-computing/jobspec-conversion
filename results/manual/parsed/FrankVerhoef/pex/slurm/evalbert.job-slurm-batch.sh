#!/bin/bash
#SBATCH --job-name=Eval_Bert
#SBATCH --output=slurm/outputs/eval_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

source ./slurm/.secrets
module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
source activate pex
cp -r data  "$TMPDIR"/data
mkdir "$TMPDIR"/logs
srun python -u run/main.py eval bert classify \
        --basedir msc/msc_personasummary/  \
        --sessions 1 2 3 4 \
	--speaker_prefixes \<other\> \<self\> \
        --batch_size 64  \
        --device cuda  \
        --loglevel VERBOSE  \
        --logdir "$TMPDIR"/logs/  \
	--datadir "$TMPDIR"/data/ \
        --checkpoint_dir ./checkpoints/ \
	--output_dir ./output/ \
	--load trained_len3_bert  \
cp "$TMPDIR"/logs/* ./logs
