#!/bin/bash
# Flux batch script

# Resources
# Nodes: 8
# Cores per node: 32 (4 tasks * 8 cpus/task)
# GPUs: 32 (8 nodes * 4 GPUs/node)

# Job name
#SBATCH -J pre_2

# Partition (replace 'default' with your desired partition)
#SBATCH -p default

# Exclusive access
#SBATCH --exclusive

# Output file
#SBATCH -o Pre2.out

# Request resources
# Flux uses a different syntax for resource requests.
# We need to specify the number of nodes, tasks per node, and GPUs per node.
# Flux automatically handles core allocation based on tasks.

# Number of nodes
export FLUX_NODES=8

# Tasks per node
export FLUX_TASKS_PER_NODE=4

# GPUs per node
export FLUX_GPUS_PER_NODE=4

# Environment variables
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Input files
input_files="/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_O_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_S_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TF_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TK_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TP_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TV_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_P_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TB_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TG_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TL_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TQ_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_U_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_Q_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TD_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TH_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TM_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TS_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_V_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_R_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TE_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TJ_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TN_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TU_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_X_512.tfrecord"

# Run the application
# Flux uses a simpler execution model.  No need for mpirun or hostfiles.
# Flux automatically distributes the tasks across the allocated resources.
python run_pretraining_hvd.py \
  --input_file "${input_files}" \
  --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
  --output_dir /work1/zzx6320/lh/Projects/bert/outputs/Pre2_cscd_all_512_from_scratch \
  --max_seq_length 512 \
  --do_train True \
  --do_eval True \
  --train_batch_size 8 \
  --learning_rate 2e-5 \
  --num_train_steps 2000000 \
  --save_checkpoints_steps 1000