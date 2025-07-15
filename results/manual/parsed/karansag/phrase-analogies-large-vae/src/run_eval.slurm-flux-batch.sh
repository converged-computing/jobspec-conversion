#!/bin/bash
#FLUX: --job-name=optimus-analogy-eval
#FLUX: -t=172800
#FLUX: --priority=16

singularity exec --nv --overlay $SCRATCH/overlay-25GB-500K-2.ext3:rw /scratch/work/public/singularity/cuda10.1-cudnn7-devel-ubuntu18.04-20201207.sif /bin/bash -c "
source /ext3/env.sh
conda activate
OPTIMUS_CHECKPOINT_DIR=/scratch/${USER}/phrase-analogies-large-vae/pretrained_models/optimus_beta10_size768-snli/checkpoint-31250 python3 run_eval.py s3://inputs/nli/snli_test_data_10000.csv s3://optimus_evaluated/nli/snli_test_data_10000_eval.csv
"
