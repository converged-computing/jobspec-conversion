#!/bin/bash
#FLUX: --job-name=ResNet50
#FLUX: -c=10
#FLUX: --queue=rtx8000,a100_2,a100_1,tandon_a100_2,tandon_a100_1,stake_a100_1,stake_a100_2
#FLUX: -t=158400
#FLUX: --urgency=16

module purge
RESOLUTION=256
MAGNIFICATION=20x
MODALITY=heightmap
MODEL=ResNet50
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
declare -a pretrainedArray=(pretrained not_pretrained)
declare -a frozenArray=(frozen unfrozen)
declare -a voteArray=(vote no_vote)
cd ..
for RESOLUTION in "${ResolutionArray[@]}"; do
	for MAGNIFICATION in "${MagnificationArray[@]}"; do
		for MODALITY in "${ModalityArray[@]}"; do
			for PRETRAINED in "${pretrainedArray[@]}"; do
				for FROZEN in "${frozenArray[@]}"; do
					for VOTE in "${voteArray[@]}"; do
						if [ $PRETRAINED == "pretrained" ];
						then
							EPOCHS=10
						else
							EPOCHS=20
						fi
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
