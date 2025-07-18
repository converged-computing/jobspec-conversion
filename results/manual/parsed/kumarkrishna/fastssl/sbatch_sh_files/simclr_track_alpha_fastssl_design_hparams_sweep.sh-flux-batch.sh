#!/bin/bash
#FLUX: --job-name=simclr_track_alpha_hparam_sweep
#FLUX: --queue=long
#FLUX: -t=23400
#FLUX: --urgency=16

export LD_PRELOAD='~/Projects/SSL_alpha/fastssl/configs/hack.so 	# Olexa's hack to avoid INTERNAL ASSERT ERROR on Pytorch 1.10'
export MKL_THREADING_LAYER='TBB'

. /etc/profile
module load anaconda/3
conda activate ffcv
export LD_PRELOAD=~/Projects/SSL_alpha/fastssl/configs/hack.so 	# Olexa's hack to avoid INTERNAL ASSERT ERROR on Pytorch 1.10
export MKL_THREADING_LAYER=TBB
temp_arr=(0.01 0.05 0.1 0.2 0.5)
proj_arr=(128 256 512 768)
dataset='stl10'
if [ $dataset = 'stl10' ]
then
    bsz_arr=(128 192 256 384)  # for stl10
else
    bsz_arr=(128 256 512 1024)  # for cifar10
fi
len1=${#temp_arr[@]}
len2=${#proj_arr[@]}
len3=${#bsz_arr[@]}
lenMul23=$((len2*len3))
idx1=$((SLURM_ARRAY_TASK_ID/lenMul23))
idx23=$((SLURM_ARRAY_TASK_ID%lenMul23))
idx2=$((idx23/len3))
idx3=$((idx23%len3))
temp=${temp_arr[$idx1]}
projector_dim=${proj_arr[$idx2]}
batch_size=${bsz_arr[$idx3]}
checkpt_dir='simclr_checkpoints_arch_hparams_track_alpha_'$dataset
model_name=resnet50proj 
python scripts/train_model.py --config-file configs/cc_SimCLR.yaml --training.temperature=$temp --training.projector_dim=$projector_dim --training.model=$model_name --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.batch_size=$batch_size --training.track_alpha=True --training.log_interval=2
model_name=resnet50feat
python scripts/train_model.py --config-file configs/cc_classifier.yaml --eval.train_algorithm='SimCLR' --training.temperature=$temp --training.projector_dim=$projector_dim --training.model=$model_name --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=1 --training.batch_size=$batch_size
python scripts/train_model.py --config-file configs/cc_classifier.yaml --eval.train_algorithm='SimCLR' --training.temperature=$temp --training.projector_dim=$projector_dim --training.model=$model_name --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=2 --training.batch_size=$batch_size
python scripts/train_model.py --config-file configs/cc_classifier.yaml --eval.train_algorithm='SimCLR' --training.temperature=$temp --training.projector_dim=$projector_dim --training.model=$model_name --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=3 --training.batch_size=$batch_size
