#!/bin/bash
#FLUX: --job-name=analogy-eval
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

singularity exec --overlay $SCRATCH/overlay-25GB-500K.ext3:ro /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04-20201207.sif /bin/bash -c "
source /ext3/env.sh
conda activate
OPTIMUS_CHECKPOINT_DIR=/scratch/${USER}/phrase-analogies-large-vae/pretrained_models/optimus_beta10_size768-snli/checkpoint-31250 python3 run.py -s bleu,exact ../datasets/comparative_sample_large.csv
"
