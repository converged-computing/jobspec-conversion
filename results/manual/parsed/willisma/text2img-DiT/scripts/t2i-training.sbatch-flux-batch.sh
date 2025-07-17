#!/bin/bash
#FLUX: --job-name=testDiT-XL
#FLUX: -c=4
#FLUX: -t=108000
#FLUX: --urgency=16

export OMP_NUM_THREADS='12'

module purge
export OMP_NUM_THREADS=12
singularity exec --nv \
	    --overlay /scratch/nm3607/container/DiT_container.ext3:ro \
		--overlay /vast/work/public/ml-datasets/coco/coco-2017.sqf:ro \
	    		  /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
	    		  /bin/bash -c \
		"source /ext3/env.sh; conda activate DiT; \
		torchrun --nnodes=1 --nproc_per_node=4 train.py \
		--model DiT-XL/2 \
		--num-workers 4 \
		--data-path /scratch/nm3607/datasets/coco/ \
		--ckpt /scratch/nm3607/DiT/t2i-results/022-DiT-XL-2/checkpoints/0150000.pt \
		--global-batch-size 128 \
		--cfg-scale 1.5"
