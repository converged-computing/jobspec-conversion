#!/bin/bash
#SBATCH --job-name=predict
#SBATCH --output=logs/predict/%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1024
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --array=0-141%100

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/sw/apps/cuda/9.0.176/lib64/:/sw/apps/cudnn/6.0/lib64/'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/sw/apps/cuda/9.0.176/lib64/:/sw/apps/cudnn/6.0/lib64/
INPUT="3-predict/source"
OUTPUT="3-predict/restored"
FILES=(${INPUT}/*.tif)
FILE=`basename ${FILES[$SLURM_ARRAY_TASK_ID]}`
python3 predict.py \
--input-dir     "${INPUT}" \
--input-pattern "${FILE}" \
--input-axes    "ZYX" \
--model-basedir "1-models" \
--model-name    "proper" \
--factor        "3" \
--output-dir    "${OUTPUT}" \
--output-name   "{file_name}{file_ext}" \
--output-dtype  "uint16" \
--n-tiles       2 8 8
