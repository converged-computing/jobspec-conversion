#!/bin/bash
#FLUX: --job-name=3
#FLUX: -N=4
#FLUX: -c=8
#FLUX: --queue=normal
#FLUX: --urgency=16

export MIOPEN_USER_DB_PATH='/tmp/tensorflow-miopen-${USER}-2.8'
export MIOPEN_DEBUG_DISABLE_FIND_DB='1'
export HOROVOD_HIERARCHICAL_ALLREDUCE='1'

DIR=`pwd`
hostfile=${DIR}/tmp
scontrol show hostnames $SLURM_JOB_NODELIST > ${hostfile}
for i in `cat ${hostfile}`
do
    echo ${i} slots=4
done > ${DIR}/hostfile-tmp
num_node=`cat ${hostfile} | uniq | wc -l`
((num_DCU=${num_node}*4))
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1
input_files=/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_O_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_S_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TF_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TK_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TP_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TV_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_P_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TB_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TG_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TL_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TQ_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_U_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_Q_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TD_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TH_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TM_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TS_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_V_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_R_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TE_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TJ_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TN_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TU_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_X_cscd_128_wwm_cmesh.tfrecord
mpirun -np ${num_DCU} --hostfile ${DIR}/hostfile-tmp -mca pml ucx -x UCX_TLS=sm,rc,rocm_cpy,rocm_gdr,rocm_ipc -x LD_LIBRARY_PATH -mca coll_hcoll_enable 0 --bind-to none \
    python run_pretraining_hvd.py\
 --input_file ${input_files}\
 --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json\
 --init_checkpoint /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_model.ckpt \
 --output_dir /work1/zzx6320/lh/Projects/bert/outputs/Pre3_cscd_all_128_64_from_bert\
 --max_seq_length 128\
 --do_train True\
 --do_eval True \
 --train_batch_size 64\
 --learning_rate 2e-5\
 --num_train_steps 3000000\
 --save_checkpoints_steps 1000\
