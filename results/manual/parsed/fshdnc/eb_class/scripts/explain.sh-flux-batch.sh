#!/bin/bash
#FLUX: --job-name=train
#FLUX: --queue=test
#FLUX: -t=600
#FLUX: --urgency=16

export SING_IMAGE='$(pwd)/eb_class_latest.sif'
export TRANSFORMERS_CACHE='$(realpath cache)'

set -euo pipefail
echo "START: $(date)"
module purge
export SING_IMAGE=$(pwd)/eb_class_latest.sif
export TRANSFORMERS_CACHE=$(realpath cache)
echo "-------------SCRIPT--------------" >&2
cat $0 >&2
echo -e "\n\n\n" >&2
srun singularity exec --nv -B /scratch:/scratch $SING_IMAGE \
    python3 -m finnessayscore.explain\
    --batch_size 1 \
    --model_type whole_essay \
    --whole_essay_overlap 5 \
    --max_length 512 \
    --jsons data/ismi-kirjoitelmat-parsed.json
    #--epochs 20 \
    #--lr 2e-5 \
    #--grad_acc 1 \
    #
    #--use_label_smoothing \
    #--smoothing 0.0 \
    #
    #--bert_path $BERT_PATH
seff $SLURM_JOBID
echo "END: $(date)"
