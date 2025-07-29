#!/bin/bash
#SBATCH --job-name=example_Satori_batch_2_nodes
#SBATCH --output=SALIENT/job_output/%x_%j.err
#SBATCH --error=SALIENT/job_output/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=1T
#SBATCH --time=00:03:00
#SBATCH --partition=sched_system_all_8
#SBATCH: --exclusive
#SBATCH --array=1-2

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
