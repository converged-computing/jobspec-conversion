#!/bin/bash
#SBATCH --job-name=vctk_AD_v0
#SBATCH --output=/mnt/home/slurmlogs/vctk/vocoder/AudioDec_v0_symAD_vctk_48000_hop300_clean.out
#SBATCH --error=/mnt/home/slurmlogs/vctk/vocoder/AudioDec_v0_symAD_vctk_48000_hop300_clean.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=64g
#SBATCH --time=7-00:00:00
#SBATCH --partition=xxx

autoencoder=autoencoder/symAD_vctk_48000_hop300
tag_name="vocoder/AudioDec_v0_symAD_vctk_48000_hop300_clean"
stage=0
resumepoint=200000
encoder_checkpoint=200000
decoder_checkpoint=500000
exp=exp # Folder of models
disable_cudnn=False
subset=test
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
    --tag ${tag_name} --resume ${resume} \
    --disable_cudnn ${disable_cudnn} 
fi
if echo ${stage} | grep -q 2; then
    echo "Testing"
    python codecTest.py \
    --subset ${subset} \
    --subset_num ${subset_num} \
    --encoder exp/${autoencoder}/checkpoint-${encoder_checkpoint}steps.pkl \
    --decoder exp/${tag_name}/checkpoint-${decoder_checkpoint}steps.pkl \
    --output_dir output/${tag_name}
fi
