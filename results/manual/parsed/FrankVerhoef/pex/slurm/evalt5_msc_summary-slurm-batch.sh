#!/bin/bash
#SBATCH --job-name=Eval_MSC_Summary
#SBATCH --output=slurm/outputs/eval_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=32G
#SBATCH --time=08:00:00
#SBATCH --partition=gpu
#SBATCH --array=5-12,37-40%4

source ./slurm/.secrets
module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module load Java/11.0.16
source activate pex
HPARAMS_FILE=$HOME/pex/slurm/eval_msc_summary_params.txt
cp -r data  "$TMPDIR"/data
mkdir "$TMPDIR"/output
srun python -u run/main.py eval t5 summarize \
	--datadir "$TMPDIR"/data/ \
	--basedir msc/msc_personasummary/ \
	--metrics terp nli rougeL \
	--speaker_prefixes \[other\] \[self\] \
	--checkpoint_dir checkpoints/ \
	--load trained_nll05final_t5 \
	--t5_base t5-base \
	--decoder_max 30 \
	--device cuda \
	--terpdir ~/terp/ \
	--java_home /sw/arch/RHEL8/EB_production/2022/software/Java/11.0.16 \
	--tmpdir "$TMPDIR"/ \
	--log_interval 10 \
	--loglevel DEBUG \
	--output_dir "$TMPDIR"/output/ \
	$(head -$SLURM_ARRAY_TASK_ID $HPARAMS_FILE | tail -1)
cp "$TMPDIR"/output/* output
