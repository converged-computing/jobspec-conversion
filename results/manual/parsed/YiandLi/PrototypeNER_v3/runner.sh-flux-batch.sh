#!/bin/bash
#FLUX: --job-name=outstanding-knife-0923
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load nvidia/cuda/10.0
module load pytorch/1.0_python3.7_gpu
python src/train.py \
    --update_per_tasks 4 \
    --eval_per_update 4 \
    --do_source_train \
    --support_test_epoch 5 \
    --inner_identify_loops 5 \
    --inner_classify_loops 10 \
    --encoder_type ../../pre_ckpts/bert-base-uncased \
    # --do_target_eval \
    # --prior_avg_by_class \
    # --post_avg_by_class \
    # --froze_encoder
