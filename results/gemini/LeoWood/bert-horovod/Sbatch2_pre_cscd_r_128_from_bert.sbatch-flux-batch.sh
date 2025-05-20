#!/bin/bash
#FLUX: -N 4
#FLUX: --tasks-per-node=4
#FLUX: --cpus-per-task=8
#FLUX: --gpus-per-node=4
#FLUX: -q normal
#FLUX: -J pre_bert
#FLUX: -o pre_cscd_r_128_from_bert.out
#FLUX: --stderr=pre_cscd_r_128_from_bert.err

# Environment variables for the application
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# The total number of MPI tasks will be automatically available in FLUX_JOB_NTASKS
# For this job: 4 nodes * 4 tasks/node = 16 tasks. Each task gets 8 CPUs and 1 GPU.

# Execute the parallel application using mpirun
# The hostfile is not needed as Flux will manage node allocation for mpirun (typically via PMIx).
# Use FLUX_JOB_NTASKS for the number of processes.
mpirun -np $FLUX_JOB_NTASKS \
    -mca pml ucx -x UCX_TLS=sm,rc,rocm_cpy,rocm_gdr,rocm_ipc \
    -x LD_LIBRARY_PATH \
    -mca coll_hcoll_enable 0 \
    --bind-to none \
    python run_pretraining_hvd.py \
    --input_file /public/home/zzx6320/lh/Projects/bert/data/cscibert_pre_training/pre_training_R_cscd_128.tfrecord \
    --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --init_checkpoint /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_model.ckpt \
    --output_dir output/Pre2_cscd_R_128_64_from_bert \
    --max_seq_length 128 \
    --do_train True \
    --do_eval True \
    --train_batch_size 64 \
    --learning_rate 2e