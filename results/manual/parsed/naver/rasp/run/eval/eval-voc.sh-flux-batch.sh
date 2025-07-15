#!/bin/bash
#FLUX: --job-name=inference
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
alias exp='python -m torch.distributed.launch --nproc_per_node=1 --master_port ${port} eval.py --num_workers 4 --sample_num 8 --logdir ${logdir} --ckpt_root ${ckptdir}'
shopt -s expand_aliases
overlap=$2
task=$3
exp_name=$4
step=$5
sem_sim=$6
dataset=voc
batch_size=1 # set batch_size=1 if --visualize_images is set, otherwise visualization code will break.
if [ ${overlap} -eq 0 ]; then
  path=${ckptdir}/step/${dataset}-${task}/
  ov=""
else
  path=${ckptdir}/step/${dataset}-${task}-ov/
  ov="--overlap"
  echo "Overlap"
fi
echo ${path}
if [ ${sem_sim} -eq 0 ]
then
  ss=""
else
  ss="--semantic_similarity"
fi
echo ${ss}
dataset_pars="--dataset ${dataset} --task ${task} --batch_size ${batch_size} $ov"
pretr_FT=${path}FT_bce_0.pth
if [ ${step} -eq 1 ]; then
  prev_ckpt_path=$pretr_FT
else
  prev_ckpt_path=${path}${exp_name}_$((${step}-1)).pth
fi
curr_ckpt_path=${path}${exp_name}_${step}.pth
exp --name ${exp_name} --step ${step} --weakly ${dataset_pars} --step_ckpt $prev_ckpt_path --curr_step_ckpt ${curr_ckpt_path} \
  --sample_num 32 --cam 'ngwp' --affinity --visualize_images ${ss}
echo "I am finishing"
