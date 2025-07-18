#!/bin/bash
#FLUX: --job-name=cowy-bits-6599
#FLUX: --exclusive
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

BATCH_SIZE=4
NUM_GPU=8
singularity exec --nv -B $(pwd):/workspace -B /raid:/raid --pwd /workspace $HOME/simg/pytorch.simg \
	python -m torch.distributed.launch --nproc_per_node=$NUM_GPU \
		train.py --dataroot $HOME/datasets/cityscape_4k \
			--name cityscape_pix2pix \
			--model pix2pix \
			--direction BtoA \
			--batch_size=$BATCH_SIZE
sleep 300
