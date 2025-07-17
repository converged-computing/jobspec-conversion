#!/bin/bash
#FLUX: --job-name=bert_finetune
#FLUX: -c=4
#FLUX: -t=37800
#FLUX: --urgency=16

module purge
singularity exec --nv --overlay /scratch/cg4174/nlp_project/env/overlay-25GB-500K.ext3:ro /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif /bin/bash << EOF
source /ext3/env.sh
python bert_finetune.py
EOF
