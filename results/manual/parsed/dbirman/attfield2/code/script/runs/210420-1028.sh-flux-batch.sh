#!/bin/bash
#FLUX: --job-name=shift
#FLUX: --queue=gpu
#FLUX: -t=9000
#FLUX: --urgency=16

ml python/3.6.1
cd $HOME/proj/attfield
source code/script/shrlk.bash_rc
J=$SLURM_ARRAY_TASK_ID
BETA=(1.1 2.0 4.0 11.0)
BETA=${BETA[$J]}
echo ">> Starting:" $(date +"%T") " : J=$J : BETA=$BETA"
echo ">> Starting:" $(date +"%T") " : J=$J : BETA=$BETA" \
    >> $DATA/runs/210420/1028_$J.py_out
$py3 $CODE/script/backprop.py \
    $DATA/runs/210420/shift_beta_$BETA.h5            `# Output Path` \
    $DATA/imagenet/imagenet_four224l0.h5                `# Image Set` \
    100                                                 `# Imgs per category` \
    $DATA/models/cZR_100units.csv                       `# Unit set` \
    '(0,0)'                                             `# Gradients w.r.t.` \
    --attn $CODE/proc/att_models/manual_shift.py        `# Model type` \
    --attn_cfg $CODE/proc/att_models/retina_b$BETA.json `# Model params` \
    --model code/cornet/cornet/cornet_zr.py             `# Model` \
    --abs                                               `# Absolute grads ` \
    --decoders '(0,5,2)'                                `# Decoder layers` \
    --batch_size 250                                    `# Limit memory` \
    --verbose                                           `# Debug` \
    --cuda                                              `# Run on GPU` \
     > $DATA/runs/210420/1028_$J.py_out \
    2> $DATA/runs/210420/1028_$J.py_err
