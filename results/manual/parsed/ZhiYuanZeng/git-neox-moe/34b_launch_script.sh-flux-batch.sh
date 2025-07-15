#!/bin/bash
#FLUX: --job-name=spicy-sundae-4010
#FLUX: -N=32
#FLUX: -c=12
#FLUX: --exclusive
#FLUX: --urgency=16

export HOSTNAMES='`scontrol show hostnames "$SLURM_JOB_NODELIST"`'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='12802'
export COUNT_NODE='`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`'
export DLTS_HOSTFILE='path/to/hostfile/hosts_$SLURM_JOBID'

source /path/to/conda_setup_script.sh
ds_report
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=12802
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
TRAIN_PATH=/path/to/gpt-neox
cd $TRAIN_PATH
bash /helper/script/write_hostfile.sh
export DLTS_HOSTFILE=path/to/hostfile/hosts_$SLURM_JOBID
python $TRAIN_PATH/deepy.py $TRAIN_PATH/train.py \
        --conf_dir /path/to/math-lm/pretraining llemma_34b.yml data_mixture.yml   
