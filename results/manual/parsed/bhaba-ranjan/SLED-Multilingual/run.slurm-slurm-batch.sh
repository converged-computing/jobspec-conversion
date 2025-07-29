#!/bin/bash
#SBATCH --job-name=gpu_basics
#SBATCH --output=gpu_basics_french_8_training.%j.out
#SBATCH --error=gpu_basics_french_8_training_error.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100.40gb:1
#SBATCH --time=11:00:00
#SBATCH --partition=gpuq
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=5

export CUDA_VISIBLE_DEVICES='0'

set echo 
umask 0022 
nvidia-smi
module load gnu10
export CUDA_VISIBLE_DEVICES=0
source /scratch/bpanigr/virtualenv-sled/bin/activate
python /scratch/bpanigr/nlp-final-project/SLED/examples/seq2seq/run.py /scratch/bpanigr/nlp-final-project/SLED/examples/seq2seq/configs/data/squad.json /scratch/bpanigr/nlp-final-project/SLED/examples/seq2seq/configs/model/bart_base_sled.json /scratch/bpanigr/nlp-final-project/SLED/examples/seq2seq/configs/training/base_training_args.json --output_dir /scratch/bpanigr/output_sled_fench_slurm --per_device_train_batch_size=8 --per_device_eval_batch_size=2
