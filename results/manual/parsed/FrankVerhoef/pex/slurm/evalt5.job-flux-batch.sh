#!/bin/bash
#FLUX: --job-name=Test_T5
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

source ./slurm/.secrets
module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module load Java/11.0.16 
source activate pex
cp -r data  "$TMPDIR"/data
mkdir "$TMPDIR"/logs
srun python -u run/main.py eval t5 generate \
	--t5_base t5-base \
    --basedir msc/msc_personasummary/  \
    --speaker_prefixes \[other\] \[self\]  \
    --sessions 1 2 3 4 \
	--batch_size 16 \
	--do_sample \
	--num_beams 5 \
	--temperature 1.5 \
	--top_p 0.9 \
	--top_k 10 \
    --decoder_max 30 \
    --device cuda  \
    --loglevel VERBOSE  \
	--terpdir ~/terp/ \
	--java_home /sw/arch/RHEL8/EB_production/2022/software/Java/11.0.16 \
	--tmpdir "$TMPDIR"/ \
    --logdir "$TMPDIR"/logs/  \
	--datadir "$TMPDIR"/data/ \
	--checkpoint_dir ./checkpoints/ \
	--output_dir ./output/ \
	--device cuda \
	--load trained_nll05final_t5
cp "$TMPDIR"/logs/* ./logs
