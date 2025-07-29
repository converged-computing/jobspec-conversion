#!/bin/bash
#FLUX: --job-name=Tune_T5
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
source activate pex
cp -r data  "$TMPDIR"/data
mkdir "$TMPDIR"/logs
mkdir "$TMPDIR"/output
srun python -u run/main.py tune t5 generate \
        --basedir msc/msc_personasummary/  \
        --sessions 2 3 \
	--train_samples 10000 \
	--valid_samples 2000 \
        --batch_size 48  \
        --learning_rate 0.0003 \
        --epochs 1  \
	--valid_interval 10 \
	--patience 4 \
        --device cuda  \
        --loglevel INFO  \
        --logdir "$TMPDIR"/logs/  \
	--datadir "$TMPDIR"/data/ \
        --output_dir "$TMPDIR"/output/ \
	--experiment_name t5_tokens_s23
cp "$TMPDIR"/logs/* ./logs
cp -r "$TMPDIR"/output/* ./output
