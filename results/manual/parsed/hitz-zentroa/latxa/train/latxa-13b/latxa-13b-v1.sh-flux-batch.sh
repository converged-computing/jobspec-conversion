#!/bin/bash
#FLUX: --job-name=faux-cat-5247
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=boost_usr_prod
#FLUX: -t=86400
#FLUX: --urgency=16

export HOSTNAMES='$(scontrol show hostnames "$SLURM_JOB_NODELIST")'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='12802'
export COUNT_NODE='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l)'
export DLTS_HOSTFILE='${HOME}/hostfiles/hosts_$SLURM_JOBID'

source ${WORK}/environments/neox-env/bin/activate
module load profile/deeplrn
module load python/3.10.8--gcc--11.3.0
module load cuda/11.8
module load openmpi/4.1.4--gcc--11.3.0-cuda-11.8
module load zlib/1.2.13--gcc--11.3.0
module load git-lfs
ds_report
export HOSTNAMES=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=12802
export COUNT_NODE=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l)
bash ${HOME}/llama-eus/leonardo/train/write_hostfile.sh
export DLTS_HOSTFILE=${HOME}/hostfiles/hosts_$SLURM_JOBID
TP=2
PP=0
SAVE_PATH=/leonardo_scratch/large/userexternal/jetxaniz/Llama-2-13b-neox-eus-v0
if [ -d "$SAVE_PATH" ]; then
  LOAD_PATH=$SAVE_PATH
  FINETUNE="false"
  CONF_NAME="continue"
  printf "Continue training from %s\n" $SAVE_PATH
else
  LOAD_PATH=/leonardo_scratch/large/userexternal/jetxaniz/Llama-2-13b-neox-TP-${TP}
  FINETUNE="true"
  CONF_NAME="start"
  printf 'Starting training from %s\n' ${LOAD_PATH}
fi
printf '{\n "save": "%s",\n "load": "%s",\n "finetune": %s\n}' ${SAVE_PATH} ${LOAD_PATH} $FINETUNE \
  >${HOME}/llama-eus/leonardo/configs/save_load/${CONF_NAME}_13B_eus_v0.yml
TRAIN_PATH=${WORK}/gpt-neox
cd $TRAIN_PATH
python $TRAIN_PATH/deepy.py $TRAIN_PATH/train.py \
  --conf_dir ${HOME}/llama-eus/leonardo/configs \
  base_config.yml \
  models/llama-2-13b.yml \
  deepspeed/zero1.yml \
  hyperparameters/13B_v1.yml \
  data/latxa-v1.yml \
  save_load/${CONF_NAME}_13B_eus_v0.yml
