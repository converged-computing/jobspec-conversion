#!/bin/bash
#FLUX: --job-name=arid-bits-5191
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load ncf/1.0.0-fasrc01
module load miniconda3/py310_22.11.1-1-linux_x64-ncf
module load cuda/12.2.0-fasrc01
source ~/.bashrc
conda activate ten
clip_gradient_flag=""
if [ "$CLIP_GRADIENT" = "True" ]; then
    clip_gradient_flag="--clip_gradient"
fi
python src/main_qm9.py --lifters "atom:0" "bond:1" "functional_group:2" "ring:2" \
                       --target_name "$TARGET_NAME" \
                       --connectivity "self_and_neighbors" \
                       --visible_dims 0 1 2 \
                       --neighbor_types "+1" "-1" \
                       --merge_neighbors \
                       --epochs 1000 \
                       --batch_size 96 \
                       --weight_decay 1e-16 \
                       --lr "$LR" \
                       --num_layers 7 \
                       --num_hidden 128 \
                       --model_name "ten" \
                       --dim 2 \
                       --splits "egnn" \
                       $clip_gradient_flag \
                       --normalize_invariants \
