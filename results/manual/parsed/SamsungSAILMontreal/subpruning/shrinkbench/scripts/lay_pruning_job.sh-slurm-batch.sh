#!/bin/bash
#SBATCH --output=outputLogs/pruning_job-%A-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --array=1-960

export PYTHONPATH='$PYTHONPATH:$HOME/subpruning/'

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "STARTING AT `date`"
source activate venv
export PYTHONPATH="$PYTHONPATH:$HOME/subpruning/"
echo $PYTHONPATH
python prune_onelayer.py -s all -b 4 -d MNIST -m LeNet -o Adam --task $SLURM_ARRAY_TASK_ID --ntasks $SLURM_ARRAY_TASK_COUNT --job $SLURM_ARRAY_JOB_ID
python prune_onelayer.py -s all -b 4 -d CIFAR10 -m vgg11_bn_small -o Adam --task $SLURM_ARRAY_TASK_ID --ntasks $SLURM_ARRAY_TASK_COUNT --job $SLURM_ARRAY_JOB_ID
python prune_onelayer.py -s all -b 4 -d CIFAR10 -m resnet56 -o Adam --task $SLURM_ARRAY_TASK_ID --ntasks $SLURM_ARRAY_TASK_COUNT --job $SLURM_ARRAY_JOB_ID
echo "FINISHING AT `date`"
