#!/bin/bash
#FLUX: --job-name=nerdy-lemur-8340
#FLUX: --exclusive
#FLUX: -t=180
#FLUX: --priority=16

export PYTHONPATH='$SALIENT_ROOT'

HOME2=/nobackup/users/$(whoami)
PYTHON_VIRTUAL_ENVIRONMENT=salient
source $HOME2/anaconda3/etc/profile.d/conda.sh
conda activate $PYTHON_VIRTUAL_ENVIRONMENT
JOB_NAME=$SLURM_JOB_NAME
SALIENT_ROOT=$HOME/SALIENT
export PYTHONPATH=$SALIENT_ROOT
DATASET_ROOT=$HOME2/dataset
OUTPUT_ROOT=$SALIENT_ROOT/job_output
DDP_DIR=$OUTPUT_ROOT/$JOB_NAME/ddp
touch $DDP_DIR/$SLURMD_NODENAME
python -m driver.main ogbn-arxiv $JOB_NAME \
       --dataset_root $DATASET_ROOT --output_root $OUTPUT_ROOT \
       --trials 2 --epochs 3 --test_epoch_frequency 2 \
       --model_name SAGE --test_type batchwise \
       --overwrite_job_dir \
       --num_workers 30 --max_num_devices_per_node 2 --total_num_nodes 2 \
       --ddp_dir $DDP_DIR
