#!/bin/bash
#SBATCH --job-name=ViT_H
#SBATCH --output=%x.out
#SBATCH --mail-user=zf540@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=1-20:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
RESOLUTION=256
MAGNIFICATION=20x
MODALITY=heightmap
MODEL=ViT_H
PRETRAINED=pretrained
FROZEN=unfrozen
EPOCHS=10
BATCH_SIZE=100
START_LR=0.01
SEED=1234
VOTE=vote
declare -a ResolutionArray=(256 512 865)
declare -a MagnificationArray=(20x 50x 20x+50x)
declare -a ModalityArray=(texture heightmap)
declare -a pretrainedArray=(pretrained)
declare -a frozenArray=(frozen unfrozen)
declare -a voteArray=(vote no_vote)
cd ..
for RESOLUTION in "${ResolutionArray[@]}"; do
	for MAGNIFICATION in "${MagnificationArray[@]}"; do
		for MODALITY in "${ModalityArray[@]}"; do
			for PRETRAINED in "${pretrainedArray[@]}"; do
				for FROZEN in "${frozenArray[@]}"; do
					for VOTE in "${voteArray[@]}"; do
						singularity exec --nv \
						--overlay ../overlay_1.ext3:ro \
						/scratch/work/public/singularity/cuda11.7.99-cudnn8.5-devel-ubuntu22.04.2.sif \
						/bin/bash -c "source /ext3/env.sh; \
						python dl_supervised_pipeline.py \
						--resolution "$RESOLUTION" \
						--magnification "$MAGNIFICATION" \
						--modality "$MODALITY" \
						--model "$MODEL" \
						--pretrained $PRETRAINED \
						--frozen $FROZEN \
						--vote $VOTE \
						--epochs $EPOCHS \
						--batch_size $BATCH_SIZE \
						--start_lr $START_LR \
						--seed $SEED"
					done
				done
			done
		done
	done
done
