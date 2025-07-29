#!/bin/bash
#FLUX: --job-name=rasp
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='$1'

conda activate /home/sroy/workspace/environments/wilson/
export CUDA_VISIBLE_DEVICES=$1
port=$(python get_free_port.py)
echo ${port}
logdir=/scratch/1/user/sroy/class-inc/logs
ckptdir=/scratch/1/user/sroy/class-inc/checkpoints
ext_dir=/scratch/1/user/sroy/ciss/ilsvrc2012
alias exp='python -m torch.distributed.launch --nproc_per_node=2 --master_port ${port} run.py --num_workers 4 --sample_num 8 --logdir ${logdir} --ckpt_root ${ckptdir}'
shopt -s expand_aliases
overlap=$2
task=$3
exp_name=$4
nb_incremental_steps=$5
lambda_sem=$6
tau=$7
semantic_similarity_type=$8
dataset=voc
epochs=40
lr_init=0.01
lr=0.001
batch_size=24
if [ ${overlap} -eq 0 ]; then
  path=${ckptdir}/step/${dataset}-${task}/
  ov=""
else
  path=${ckptdir}/step/${dataset}-${task}-ov/
  ov="--overlap"
  echo "Overlap"
fi
echo ${path}
dataset_pars="--dataset ${dataset} --task ${task} --batch_size ${batch_size} --epochs ${epochs} $ov"
pretr_FT=${path}FT_bce_0.pth
if [[ ! -f $pretr_FT ]]
then
  exp --name FT_bce --step 0 --bce --lr ${lr_init} ${dataset_pars}
fi
for i in $(seq $nb_incremental_steps)
do
  if [ ${i} -eq 1 ]; then
    ckpt_path=$pretr_FT
  else
    ckpt_path=${path}${exp_name}_$((i-1)).pth
  fi
  exp --name ${exp_name} --step ${i} --weakly ${dataset_pars} --alpha 0.5 --lr ${lr} --step_ckpt $ckpt_path \
    --loss_de 1 --lr_policy warmup --sample_num 32 --cam 'ngwp' --affinity \
    --val_interval 5 --pseudo_ep 5 \
    --semantic_similarity --lambda_sem=${lambda_sem} --tau=${tau} --similarity_type=${semantic_similarity_type}
done
echo "I am finishing"
