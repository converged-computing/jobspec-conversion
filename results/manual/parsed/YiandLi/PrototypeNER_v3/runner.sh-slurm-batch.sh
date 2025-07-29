#!/bin/bash
#SBATCH --output=print.log
#SBATCH --error=log.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --no-requeue

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
