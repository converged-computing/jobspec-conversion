#!/bin/bash
#FLUX: --job-name=dreambooth-inference
#FLUX: -t=540000
#FLUX: --urgency=16

hostname
which python3
nvidia-smi
env
source ~/.bashrc
cd /home/stud/xiec/anaconda3/bin
source activate
conda activate ldm
cd /home/stud/xiec/workarea/Dreambooth-Stable-Diffusion
python3 scripts/stable_txt2img.py --ddim_eta 0.0 \
	--n_samples 1 \
	--n_iter 4 \
	--scale 10.0 \
	--ddim_steps 80 \
	--ckpt /home/stud/xiec/workarea/Dreambooth-Stable-Diffusion/logdir/cat2022-12-18T10-38-11_dreambooth-training/checkpoints/last.ckpt \
	--prompt "a cross of a sks cat and a panda"
