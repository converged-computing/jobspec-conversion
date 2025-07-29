#!/bin/bash
#SBATCH --output=logs/slurm-%x-%j-%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --partition=gpu

IMG=/home/software/singularity/pytorch.simg:2024-03-11
cd ~/particleflow
singularity exec -B /scratch/persistent --nv \
    --env PYTHONPATH=hep_tfds \
    --env KERAS_BACKEND=torch \
    $IMG python3.10 mlpf/pyg_pipeline.py --dataset cms --gpus 1 \
    --data-dir /scratch/persistent/joosep/tensorflow_datasets --config parameters/pytorch/pyg-cms.yaml \
    --train --conv-type attention --num-epochs 100 --gpu-batch-multiplier 20 --num-workers 4 --prefetch-factor 50 --checkpoint-freq 1 --comet
