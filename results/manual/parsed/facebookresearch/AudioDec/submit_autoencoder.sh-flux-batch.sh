#!/bin/bash
#FLUX: --job-name=ae_vctk
#FLUX: --urgency=16

tag_name="autoencoder/symAD_vctk_48000_hop300"
stage=0
resumepoint=200000
encoder_checkpoint=200000
decoder_checkpoint=700000
exp=exp # Folder of models
disable_cudnn=False
subset="test"
subset_num=-1
. ./parse_options.sh || exit 1;
config_name="config/${tag_name}.yaml"
echo "Configuration file="$config_name
if echo ${stage} | grep -q 0; then
    echo "Training from scratch"
    python codecTrain.py \
    -c ${config_name} \
    --tag ${tag_name} \
    --exp_root ${exp} \
    --disable_cudnn ${disable_cudnn} 
fi
if echo ${stage} | grep -q 1; then
    resume=exp/${tag_name}/checkpoint-${resumepoint}steps.pkl
    echo "Resume from ${resume}"
    python codecTrain.py \
    -c ${config_name} \
    --tag ${tag_name} \
    --resume ${resume} \
    --disable_cudnn ${disable_cudnn} 
fi
if echo ${stage} | grep -q 2; then
    echo "Testing"
    python codecTest.py \
    --subset ${subset} \
    --subset_num ${subset_num} \
    --encoder exp/${tag_name}/checkpoint-${encoder_checkpoint}steps.pkl \
    --decoder exp/${tag_name}/checkpoint-${decoder_checkpoint}steps.pkl \
    --output_dir output/${tag_name}
fi
