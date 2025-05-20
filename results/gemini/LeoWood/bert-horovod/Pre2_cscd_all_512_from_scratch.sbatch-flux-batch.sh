#!/bin/bash
#flux: -N 8
#flux: --tasks-per-node=4
#flux: --cpus-per-task=8
#flux: --gpus-per-task=1
#flux: --exclusive
#flux: --output=Pre2.out
#flux: --job-name=pre_2
#flux: -q normal  # Assuming 'normal' is a valid queue name in the Flux setup

# Environment variables for the application
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Ensure LD_LIBRARY_PATH from submission environment is available for mpirun -x
export LD_LIBRARY_PATH

# Define input files (very long string)
input_files=/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_O_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_S_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TF_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TK_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TP_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TV_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_P_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TB_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TG_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TL_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TQ_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_U_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_Q_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TD_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TH_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TM_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TS_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_V_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_R_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TE_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TJ_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TN_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_TU_512.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_pre/pre_training_X_512.tfrecord

# FLUX_NTASKS will be set by Flux to the total number of tasks (32 in this case)
# This mpirun command assumes OpenMPI is built with PMIx support to integrate with Flux.
# The hostfile is not needed as Flux manages process placement.
mpirun -np $FLUX_NTASKS \
    -mca pml ucx \
    -x UCX_TLS=sm,rc,rocm_cpy,rocm_gdr,rocm_ipc \
    -x LD_LIBRARY_PATH \
    -mca coll_hcoll_enable 0 \
    --bind-to none \
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
```