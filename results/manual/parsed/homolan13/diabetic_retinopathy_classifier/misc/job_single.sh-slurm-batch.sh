#!/bin/bash
#SBATCH --job-name=single
#SBATCH --output=%x_%A_%a.out
#SBATCH --mail-user=<--YOUR-EMAIL-HERE-->
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx3090:1
#SBATCH --mem=4G
#SBATCH --time=08:00:00
#SBATCH --array=1-9%3

singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install -U tensorboard
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install -U scikit-learn
param_store=args1.txt
type=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
backbone=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')
fvs=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $3}')
image_modality=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $4}')
image_size=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $5}')
batch_size=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $6}')
suffix=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $7}')
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime python training.py -t $type -b $backbone -v $fvs -m $image_modality -i $image_size -s $batch_size -n $suffix
