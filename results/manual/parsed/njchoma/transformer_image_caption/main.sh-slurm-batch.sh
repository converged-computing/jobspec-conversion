#!/bin/bash
#SBATCH --job-name=main_run
#SBATCH --output=slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=80GB
#SBATCH --time=1-06:00:00
#SBATCH --constraint=ntasks-per-node=10

SRCDIR=$HOME/repos/transformer_image_caption/src/
cd $SRCDIR
source activate imageCaptioning
ARTIFACTS_DIR=/scratch/ovd208/IC_training
ROOT_DIR=/scratch/ovd208/COCO_features/data
EXP_NAME=baseline_full
MODEL_NAME=bottom_up
python train.py --root_dir $ROOT_DIR --artifacts_dir $ARTIFACTS_DIR --name $EXP_NAME --batch_size 100 --max_nb_epochs 10 --lr 0.00005 --opt Adam --run_nb 0 --resume_epoch 0 --beam_search --teacher_forcing 1 --model_type $MODEL_NAME
