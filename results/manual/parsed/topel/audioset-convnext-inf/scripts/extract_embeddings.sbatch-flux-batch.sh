#!/bin/bash
#FLUX: --job-name=Embed
#FLUX: -c=10
#FLUX: -t=7200
#FLUX: --urgency=16

PYTHON=/gpfswork/rech/mjp/uzj43um/conda-envs/audio_retrieval/bin/python
set -x
date
WORKSPACE_SCRATCH=/gpfsscratch/rech/djl/uzj43um/audioset_tagging   
DATASPACE=/gpfsstore/rech/djl/uzj43um/audioset
BASEDIR=/gpfswork/rech/djl/uzj43um/audio_retrieval/audioset-convnext-inf
SCRIPT=$BASEDIR/pytorch/extract_embeddings.py
srun $PYTHON -u $SCRIPT
