#!/bin/bash
#FLUX: --job-name=Chat
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

source ./slurm/.secrets
module purge
module load 2022
module load Anaconda3/2022.05
module load PyTorch/1.12.0-foss-2022a-CUDA-11.7.0
module load Java/11.0.16
source activate pex
cp -r data  "$TMPDIR"/data
cp chatstarters.txt "$TMPDIR"
mkdir "$TMPDIR"/logs
mkdir "$TMPDIR"/output
srun python -u run/main.py chat dialogpt dialog \
	--checkpoint_dir checkpoints/ \
	--load trained_fb_hpc_s4_nll05bart_dgpt \
	--lm gpt2 \
	--datadir "$TMPDIR"/data/ \
	--basedir msc/msc_dialogue/ \
	--speaker_prefixes \<other\> \<self\> \
	--sessionbreak \<session\> \
	--include_persona \
	--augmented \
	--session 4 \
	--chat_initfile "$TMPDIR"/chatstarters.txt \
	--decoder_max 50 \
	--do_sample \
	--num_beams 1 \
	--temperature 1.5 \
	--top_p 0.9 \
	--top_k 10 \
	--device cuda \
	--log_interval 10 \
	--loglevel VERBOSE \
	--seed 1968 \
	--logdir "$TMPDIR"/logs/  \
	--output_dir "$TMPDIR"/output/
cp "$TMPDIR"/logs/* ./logs
cp "$TMPDIR"/output/* output
