#!/bin/bash
#SBATCH --output=out.log
#SBATCH --error=err.logpip
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --no-requeue

module load nvidia/cuda/10.0
module load pytorch/1.0_python3.7_gpu
python src/train_CME.py \
  --do_train \
  --do_predict \
  --bert_model_path ../pre_ckpts/my_mengzi_9 \
  --data_dir datasets/split_data \
  --batch_size 16 \
  --epoch 32 \
  --encoder_learning_rate 2e-5 \
  --decoder_learning_rate 4e-4 \
  --do_rdrop \
  --rdrop_alpha 1 
