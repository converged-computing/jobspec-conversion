#!/bin/bash
#SBATCH --job-name=Selfchat
#SBATCH --output=slurm/outputs/chat_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --begin=2023-07-25T04:00:00
#SBATCH --array=[13]%6

source ./slurm/.secrets
module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module load Java/11.0.16
source activate pex
HPARAMS_FILE=$HOME/pex/slurm/selfchat_params.txt
cp -r data  "$TMPDIR"/data
mkdir "$TMPDIR"/logs
mkdir "$TMPDIR"/output
srun python -u run/main.py selfchat dialogpt dialog \
	--checkpoint_dir checkpoints/ \
	--lm gpt2 \
	--speechact_classifier trained_speechact_bert \
	--datadir "$TMPDIR"/data/ \
	--basedir msc/msc_dialogue/ \
	--speaker_prefixes \<other\> \<self\> \
	--sessionbreak \<session\> \
	--decoder_max 50 \
	--device cuda \
	--log_interval 10 \
	--loglevel VERBOSE \
	--seed 1968 \
	--logdir "$TMPDIR"/logs/  \
	--output_dir "$TMPDIR"/output/ \
	$(head -$SLURM_ARRAY_TASK_ID $HPARAMS_FILE | tail -1)
cp "$TMPDIR"/logs/* ./logs
cp "$TMPDIR"/output/* output
