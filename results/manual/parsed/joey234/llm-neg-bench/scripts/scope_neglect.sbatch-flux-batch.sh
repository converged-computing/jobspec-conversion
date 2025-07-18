#!/bin/bash
#FLUX: --job-name=run-scope-neglect
#FLUX: -t=86399
#FLUX: --urgency=16

REPO_DIR=$HOME/inverse-scaling-eval-pipeline
EXP_DIR=scope-neglect
singularity exec --nv --overlay $SCRATCH/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "
source /ext3/env.sh
conda activate invscaling
python ${REPO_DIR}/eval_pipeline/main.py \
	--dataset scope_neglect \
	--exp-dir $EXP_DIR \
	--models gpt2 gpt2-medium gpt2-large gpt2-xl \
	--use-gpu \
&& \
python ${REPO_DIR}/eval_pipeline/plot_loss.py \
	$EXP_DIR
"
