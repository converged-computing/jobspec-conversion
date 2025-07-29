#!/bin/bash
#SBATCH --job-name=train_CostFourierVelModelRGB
#SBATCH --output=/home/mguamanc/job_%j.out
#SBATCH --error=/home/mguamanc/job_%j.err
#SBATCH --mail-user=mguamanc@andrew.cmu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=65536
#SBATCH --time=1-00:00:00
#SBATCH --nodelist=calculon

EXE=/bin/bash
WORKING_DIR=/data/datasets/mguamanc/learned_cost_map/cluster_scripts
EXE_SCRIPT=$WORKING_DIR/train_CostFourierVelModelRGB.sh
USER=mguamanc
nvidia-docker run --rm --ipc=host -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /data/datasets:/data/datasets -v /home/$USER:/home/$USER -v /project:/project mguamanc/sara $EXE $EXE_SCRIPT
