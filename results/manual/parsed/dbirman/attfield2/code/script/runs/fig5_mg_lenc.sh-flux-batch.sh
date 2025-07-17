#!/bin/bash
#FLUX: --job-name=f5_mg_lenc
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

source ~/.bash_profile
ml python/3.6.1
cd $HOME/proj/attfield
source code/script/shrlk.bash_rc
J=$SLURM_ARRAY_TASK_ID
BETA=(1.1 2.0 4.0 11.0)
BETA=${BETA[$J]}
N_IMG_PER_CAT=100  # <5 min for 100
LOG="$DATA/runs/fig5/logs/mg_lenc_b$BETA"
echo ">> Starting:" $(date +"%T") " : J=$J : BETA=$BETA"
echo ">> Starting:" $(date +"%T") " : J=$J : BETA=$BETA" \
     > $LOG.py_out
F="$DATA/models/fields/field_gauss_b$BETA.h5"
IMG=$DATA/imagenet/imagenet_four224l0.h5
py3 $CODE/script/encodings.py \
    $DATA/runs/fig5/lenc_mg_n${N_IMG_PER_CAT}_b$BETA.h5   `# Output Path` \
    $CODE/proc/image_gen/det_task.py                `# Image Set` \
    code/cornet/cornet/cornet_zr.py                 `# Model` \
    "(0,1,0)" "(0,2,0)" "(0,3,0)" "(0,4,0)"         `# Pull layer` \
    --gen_cfg "img=$IMG:n=$N_IMG_PER_CAT"           `# Image config` \
    --cuda --batch_size 100     `# on 16g gpu`       \
    --attn $CODE/proc/att_models/field_shift.py  `# Attention` \
    --attn_cfg "layer=(0,1,0):beta=1.0:field_file=$F" \
     > $LOG.py_out \
    2> $LOG.py_err
