#!/bin/bash
#SBATCH --job-name=Embed
#SBATCH --account=owj@v100
#SBATCH --output=./sbatch_log.out
#SBATCH --error=./sbatch_log.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=v100-32g,ntasks-per-node=1

PYTHON=/gpfswork/rech/mjp/uzj43um/conda-envs/audio_retrieval/bin/python
set -x
date
WORKSPACE_SCRATCH=/gpfsscratch/rech/djl/uzj43um/audioset_tagging   
DATASPACE=/gpfsstore/rech/djl/uzj43um/audioset
BASEDIR=/gpfswork/rech/djl/uzj43um/audio_retrieval/audioset-convnext-inf
SCRIPT=$BASEDIR/pytorch/extract_embeddings.py
srun $PYTHON -u $SCRIPT
