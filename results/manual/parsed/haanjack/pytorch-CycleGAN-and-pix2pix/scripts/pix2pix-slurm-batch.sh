#!/bin/bash
#SBATCH --output=logs/R-%j-b$BATCH_SIZE-g$NUM_GPU-%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive

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
