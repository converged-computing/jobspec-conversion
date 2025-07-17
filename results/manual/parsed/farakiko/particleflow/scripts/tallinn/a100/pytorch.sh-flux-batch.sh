#!/bin/bash
#FLUX: --job-name=hairy-squidward-8625
#FLUX: --queue=gpu
#FLUX: --urgency=16

IMG=/home/software/singularity/pytorch.simg:2024-03-11
cd ~/particleflow
singularity exec -B /scratch/persistent --nv \
    --env PYTHONPATH=hep_tfds \
    --env KERAS_BACKEND=torch \
    $IMG python3.10 mlpf/pyg_pipeline.py --dataset cms --gpus 1 \
    --data-dir /scratch/persistent/joosep/tensorflow_datasets --config parameters/pytorch/pyg-cms.yaml \
    --train --conv-type attention --num-epochs 100 --gpu-batch-multiplier 20 --num-workers 4 --prefetch-factor 50 --checkpoint-freq 1 --comet
