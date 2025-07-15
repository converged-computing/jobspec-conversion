#!/bin/bash
#FLUX: --job-name=train
#FLUX: --queue=gpusmall
#FLUX: -t=3600
#FLUX: --urgency=16

export SING_IMAGE='/scratch/project_2004993/sifs/eb_class_latest.sif'

set -euo pipefail
echo "START: $(date)"
module purge
export SING_IMAGE=/scratch/project_2004993/sifs/eb_class_latest.sif
echo "-------------SCRIPT--------------" >&2
cat $0 >&2
echo -e "\n\n\n" >&2
srun singularity exec --nv -B /scratch:/scratch $SING_IMAGE \
    python3 -m finnessayscore.train \
    --gpus 1 \
    --epochs 1 \
    --lr 1e-5 \
    --batch_size 16 \
    --grad_acc 3 \
    --model_type trunc_essay \
    --data_dir data/ismi \
    --max_length 512
    #--bert_path $BERT_PATH \
    #--use_label_smoothing \
    #--smoothing 0.0 \
    #--whole_essay_overlap 5
seff $SLURM_JOBID
echo "END: $(date)"
