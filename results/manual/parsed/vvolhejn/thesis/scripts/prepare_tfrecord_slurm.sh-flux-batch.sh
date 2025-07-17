#!/bin/bash
#FLUX: --job-name=psycho-lamp-2453
#FLUX: -c=16
#FLUX: --queue=amdv100,intelv100,amdrtx,amda100
#FLUX: -t=28800
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'
export XLA_FLAGS='--xla_gpu_cuda_data_dir=/users/vvolhejn/miniconda3/envs/nas/lib'

echo "Running"
nvidia-smi
source ~/.bashrc
conda activate nas
echo Python executable: "$(which python || true)"
export CUDA_VISIBLE_DEVICES="0"
export XLA_FLAGS="--xla_gpu_cuda_data_dir=/users/vvolhejn/miniconda3/envs/nas/lib"
AUDIO_FILEPATTERN="$HOME/datasets_raw/guitarset/*solo_mix.wav"
TRAIN_TFRECORD=$HOME'/datasets/guitar4/guitar4.tfrecord'
ddsp_prepare_tfrecord \
    --input_audio_filepatterns=$AUDIO_FILEPATTERN \
    --output_tfrecord_path=$TRAIN_TFRECORD \
    --sample_rate=44100 \
    --num_shards=10 \
    --alsologtostderr \
    --frame_rate=50 \
    --example_secs=4.0 \
    --hop_secs=1.0 \
    --viterbi=True \
    --jukebox=True \
    --center=True \
    --eval_split_fraction=0.1
