#!/bin/bash
#SBATCH --job-name=resnet_train
#SBATCH --account=general-gpu
#SBATCH --output=results-%j.out
#SBATCH --mail-user=mjc6r9@mail.missouri.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:GeForce GTX 1080 Ti:1
#SBATCH --mem=16G
#SBATCH --time=1-00:23:00
#SBATCH --partition=gpu3

echo "### Starting at: $(date) ###"
modelname='October17_ava_30ep_MINI512_resnet_adam_regression'
dataset='ava'
epochs='30'
batch='512'
architecture='resnet'
subject='quality'
freeze='freeze'
lr='0.1'
mo='0.9'
optimizer='adam'
classification='False'
testflag='0'
python ../background_tasks/model_builder.py $modelname $dataset $epochs $batch $architecture $subject $freeze $lr $mo $optimizer $classification $testflag
echo "### Ending at: $(date) ###"
