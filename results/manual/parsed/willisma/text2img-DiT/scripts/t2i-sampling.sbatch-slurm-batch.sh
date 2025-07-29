#!/bin/bash
#FLUX: --job-name=sampleDiT
#FLUX: -t=600
#FLUX: --urgency=16

module purge
singularity exec --nv \
	    --overlay /scratch/nm3607/container/DiT_sample.ext3:ro \
	    /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
	    /bin/bash -c "source /ext3/env.sh; conda activate DiT; \
		python sample.py \
		--model DiT-XL/2 \
		--ckpt /scratch/nm3607/DiT/t2i-results/006-DiT-XL-2/checkpoints/0250000.pt \
		--data-path /scratch/nm3607/datasets/coco \
		--cfg-scale 1.5"
