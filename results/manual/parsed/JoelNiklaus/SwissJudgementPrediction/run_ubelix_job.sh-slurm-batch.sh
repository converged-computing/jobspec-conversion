#!/bin/bash
#SBATCH --job-name=SJP
#SBATCH --mail-user=joel.niklaus@inf.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx3090:1
#SBATCH --mem=64GB
#SBATCH --time=20-00:00:00
#SBATCH --qos=job_gpu_stuermer
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=2-4

eval "$(conda shell.bash hook)"
conda activate sjp
bash run.sh --train_type=$1 --train_mode=$2 --model_name=$3 --model_type=$4 --train_languages=$5 --test_languages=$6 --jurisdiction=$7 --data_augmentation_type=$8 --train_sub_datasets=$9 --sub_datasets=${10} \
  --seed=${SLURM_ARRAY_TASK_ID} --debug=False >current-run.out
