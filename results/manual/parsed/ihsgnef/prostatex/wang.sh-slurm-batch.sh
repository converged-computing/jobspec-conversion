#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=/home/hanliu/slurm_out/%j.%N.stdout
#SBATCH --error=/home/hanliu/slurm_out/%j.%N.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=20000
#SBATCH --chdir=/net/scratch/hanliu/radiology/prostatex

export FOLD='4'
export msin='ABDEFKT'
export pzn='BEFK'
export tzn='ABFT'

hostname
echo $CUDA_VISIBLE_DEVICES
export FOLD=4
export msin=ABDEFKT
export pzn=BEFK
export tzn=ABFT
python wang_args.py \
  --mri_sequences=$msin \
  --data_sequences=TBAKDEF \
  --fn_penalty=20 \
  --embed_dim=10 \
  --wandb_mode=online \
  --wandb_group=wang-emb10 \
  --output_dir=results/wang-emb10 \
  --train_dir=tbakd3_npy/5folds/$FOLD/train \
  --valid_dir=tbakd3_npy/5folds/$FOLD/valid \
  --dataloader_num_workers=8 \
  --gpus=1 \
  --seed=42 \
  --max_epochs=200 \
  --learning_rate=1e-4 \
  --vertical_flip=0.5 \
  --rotate=30 \
  --scale=0.2 \
  --train_batch_size=16 \
  --eval_batch_size=-1 \
  --do_train \
  --pooling \
  # --wandb_group=wang-tzn-fold-bal \
  # --output_dir=results/wang-tzn-fold-bal \
  # --train_dir=tbakd3_npy/tz/5folds/$FOLD/train_bal \
  # --valid_dir=tbakd3_npy/tz/5folds/$FOLD/valid_bal \
