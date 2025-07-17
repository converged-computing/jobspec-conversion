#!/bin/bash
#FLUX: --job-name=vctk_denoise
#FLUX: -c=16
#FLUX: --queue=xxx
#FLUX: -t=86400
#FLUX: --urgency=16

encoder="denoise/symAD_vctk_48000_hop300"
decoder="vocoder/AudioDec_v1_symAD_vctk_48000_hop300_clean"
stage=0
resumepoint=200000
encoder_checkpoint=200000
decoder_checkpoint=500000
exp=exp # Folder of models
disable_cudnn=False
subset="noisy_test"
. ./parse_options.sh || exit 1;
if echo ${stage} | grep -q 0; then
    echo "Denoising Training"
    config_name="config/${encoder}.yaml"
    echo "Configuration file="$config_name
    python codecTrain.py \
    -c ${config_name} \
    --tag ${encoder} \
    --exp_root ${exp} \
    --disable_cudnn ${disable_cudnn} 
fi
if echo ${stage} | grep -q 1; then
    resume=exp/${encoder}/checkpoint-${resumepoint}steps.pkl
    echo "Resume from ${resume}"
    config_name="config/${encoder}.yaml"
    python codecTrain.py -c ${config_name} --tag ${encoder} --resume ${resume} \
    --disable_cudnn ${disable_cudnn} 
fi
if echo ${stage} | grep -q 2; then
    echo "Denoising Testing"
    python codecTest.py --subset ${subset} \
    --encoder exp/${encoder}/checkpoint-${encoder_checkpoint}steps.pkl \
    --decoder exp/${decoder}/checkpoint-${decoder_checkpoint}steps.pkl \
    --output_dir output/${encoder}
fi
