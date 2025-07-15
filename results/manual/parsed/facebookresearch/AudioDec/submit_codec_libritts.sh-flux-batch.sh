#!/bin/bash
#FLUX: --job-name=AD_libritts
#FLUX: --urgency=16

autoencoder=autoencoder/symAD_libritts_24000_hop300
statistic=statistic/symAD_libritts_24000_hop300_clean
vocoder=vocoder/AudioDec_v1_symAD_libritts_24000_hop300_clean
start=-1 # stage to start
stop=100 # stage to stop
resumepoint=500000
encoder_checkpoint=500000
decoder_checkpoint=500000
exp=exp # Folder of models
disable_cudnn=False
statistic_subset=train
test_subset=test
subset_num=-1
. ./parse_options.sh || exit 1;
if [ "${start}" -le 0 ] && [ "${stop}" -ge 0 ]; then
    echo "AutoEncoder Training"
    config_name="config/${autoencoder}.yaml"
    echo "Configuration file="$config_name
    python codecTrain.py \
    -c ${config_name} \
    --tag ${autoencoder} \
    --exp_root ${exp} \
    --disable_cudnn ${disable_cudnn} 
fi
if [ "${start}" -le 1 ] && [ "${stop}" -ge 1 ]; then
    echo "Statistics Extraction"
    config_name="config/${statistic}.yaml"
    echo "Configuration file="$config_name
    python codecStatistic.py \
    -c ${config_name} \
    --subset ${statistic_subset} \
    --subset_num ${subset_num}
fi
if [ "${start}" -le 2 ] && [ "${stop}" -ge 2 ]; then
    echo "Vocoder Training"
    config_name="config/${vocoder}.yaml"
    echo "Configuration file="$config_name
    python codecTrain.py \
    -c ${config_name} \
    --tag ${vocoder} \
    --exp_root ${exp} \
    --disable_cudnn ${disable_cudnn} 
fi
if [ "${start}" -le 3 ] && [ "${stop}" -ge 3 ]; then
    echo "Testing (AutoEncoder)"
    python codecTest.py \
    --subset ${test_subset} \
    --encoder exp/${autoencoder}/checkpoint-${encoder_checkpoint}steps.pkl \
    --decoder exp/${autoencoder}/checkpoint-$((${encoder_checkpoint}+${decoder_checkpoint}))steps.pkl \
    --output_dir output/${autoencoder}
fi
if [ "${start}" -le 4 ] && [ "${stop}" -ge 4 ]; then
    echo "Testing (AutoEncoder + Vocoder)"
    python codecTest.py \
    --subset ${test_subset} \
    --encoder exp/${autoencoder}/checkpoint-${encoder_checkpoint}steps.pkl \
    --decoder exp/${vocoder}/checkpoint-${decoder_checkpoint}steps.pkl \
    --output_dir output/${vocoder}
fi
