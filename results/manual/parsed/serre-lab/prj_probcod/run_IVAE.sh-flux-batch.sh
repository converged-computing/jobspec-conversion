#!/bin/bash
#FLUX: --job-name=SVI_seeds
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

module load anaconda/3-5.2.0
source activate py36
type=SVI
hdim1=512
hdim2=256
zdim=2
activation_function=tanh
layer=fc
decoder_type='gaussian'
beta_list=(1.5)
seed=$SLURM_ARRAY_TASK_ID
svi_lr=1e-2
nb_it=100
svi_optimizer=Adam
var_init=0.001
lr=1e-3
nb_epoch=200
train_optimizer=Adam
verbose=1
EXP_PATH="/users/azerroug/scratch"
DATA_DIR="${EXP_PATH}/MNIST/"
path_db="../probcod_dbs/"
for beta in ${beta_list[@]}; do
NOW=$(date +"%Y-%m-%d_%H-%M-%S")
exp_name="${NOW}_${type}_svi_lr=${svi_lr}_lr=${lr}_beta=${beta}_nb_it=${nb_it}_[${hdim1},${hdim2},${zdim}]_af=${activation_function}_layer=${layer}_decoder=${decoder_type}_varinit=${var_init}_seed=${seed}"
path="${EXP_PATH}/prj_probcod_exps/$exp_name"
rm -rf $path
echo $exp_name
python train_vae.py \
    --exp_name $exp_name \
    --path_db $path_db \
    --type $type \
    --svi_lr $svi_lr \
    --nb_it $nb_it \
    --nb_epoch $nb_epoch \
    --lr $lr \
    --path $path \
    --arch $hdim1 $hdim2 \
    --z_dim $zdim \
    --activation_function $activation_function \
    --layer $layer \
    --var_init $var_init \
    --svi_optimizer $svi_optimizer \
    --train_optimizer $train_optimizer \
    --seed $seed \
    --beta $beta \
    --decoder_type $decoder_type \
    --verbose $verbose \
    --data_dir $DATA_DIR \
    # > logs/${exp_name}.log 2>&1 &
done
