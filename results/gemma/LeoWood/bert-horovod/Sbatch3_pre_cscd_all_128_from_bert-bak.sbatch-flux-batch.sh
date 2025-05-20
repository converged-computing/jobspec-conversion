# Flux batch script

# Request resources
# Nodes: 10
# Cores per node: 4 * 8 = 32
# GPUs: 40
# Total cores: 320

# Flux resource requests
# -n <count>: Number of ranks/processes
# -N <count>: Number of nodes
# -g <count>: Number of GPUs per node
# -c <count>: Number of cores per node

# The script calculates the number of DCUs (GPUs) based on the number of nodes.
# Flux doesn't have a direct equivalent to SLURM's --gres=dcu.  We'll request the total number of GPUs.

# Flux doesn't have partitions like SLURM.  The 'normal' partition is not directly translatable.

# Set environment variables
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Input files (long list)
input_files="/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_O_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_S_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TF_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TK_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TP_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TV_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_P_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TB_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TG_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TL_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TQ_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_U_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_Q_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TD_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TH_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TM_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TS_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_V_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_R_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TE_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TJ_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TN_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_TU_cscd_128.tfrecord,/public/home/zzx6320/lh/Projects/Data/cscd_all/pre_training_X_cscd_128.tfrecord"

# Run the application
# Flux uses a simpler mpirun-like command.  We'll specify the number of ranks (total DCUs)
# and pass the input files as arguments.
# Flux handles the hostfile internally based on resource requests.

mpirun -n 40 -c 8 --oversubscribe=false \
    python run_pretraining_hvd.py \
    --input_file "${input_files}" \
    --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --init_checkpoint /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_model.ckpt \
    --output_dir output/Pre3_cscd_all_128_64_from_bert \
    --max_seq_length 128 \
    --do_train True \
    --do_eval True \
    --train_batch_size 64 \
    --learning_rate 2e-5 \
    --num_train_steps 1000000 \
    --save_checkpoints_steps 1000