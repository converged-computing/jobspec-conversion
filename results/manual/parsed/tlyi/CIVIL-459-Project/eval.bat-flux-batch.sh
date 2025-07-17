#!/bin/bash
#FLUX: --job-name=crusty-platanos-3518
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

python3 -m openpifpaf.eval \
--dataset=openlane --loader-workers=1 \
--checkpoint outputs/2kps/2kps_10percent_2ndrun.epoch079 \
--seed-threshold=0.2 \
--openlane-train-annotations data_openlane_2kps/annotations/openlane_keypoints_sample_training.json \
--openlane-val-annotations data_openlane_2kps/annotations/openlane_keypoints_sample_validation.json \
--openlane-train-image-dir /work/scitas-share/datasets/Vita/civil-459/OpenLane/raw/images/training \
--openlane-val-image-dir /work/scitas-share/datasets/Vita/civil-459/OpenLane/raw/images/validation \
--output eval/2kps_meanpixelerror_print3
