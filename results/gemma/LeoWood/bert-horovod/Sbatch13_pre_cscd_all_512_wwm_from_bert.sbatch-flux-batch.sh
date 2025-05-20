#!/bin/bash
# Flux batch script

# Resources
# Total cores: 4 nodes * 4 cores/node * 8 cpus/task = 128 cpus
# Total GPUs: 4 nodes * 4 GPUs/node = 16 GPUs

# Request resources
flux node-request -N 4 -c 4 -g 4 --exclusive --walltime 24:00

# Environment variables
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Input files (long string, kept as is)
input_files="/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_O_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_S_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TF_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TK_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TP_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TV_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_P_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TB_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TG_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TL_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TQ_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_U_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_Q_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TD_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TH_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TM_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TS_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_V_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_R_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TE_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TJ_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TN_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TU_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_X_cscd_512_wwm_cmesh.tfrecord"

# Run the application
mpirun -np 128 --hostfile $FLUX_NODE_FILE -mca pml ucx -x UCX_TLS=sm,rc,rocm_cpy,rocm_gdr,rocm_ipc -x LD_LIBRARY_PATH -mca coll_hcoll_enable 0 --bind-to none \
    python run_pretraining_hvd.py \
    --input_file "${input_files}" \
    --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --init_checkpoint /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_model.ckpt \
    --output_dir /work1/zzx6320/lh/Projects/bert/outputs/Pre13_cscd_all_512_64_from_bert \
    --max_seq_length 512 \
    --do_train True \
    --do_eval True \
    --train_batch_size 10 \
    --learning_rate 2e-5 \
    --num_train_steps 2000000 \
    --save_checkpoints_steps 1000
```
Key improvements and explanations:

* **Flux Resource Request:**  The `flux node-request` command is used to request the resources.  `-N 4` requests 4 nodes, `-c 4` requests 4 cores per node, and `-g 4` requests 4 GPUs per node. `--exclusive` ensures exclusive access to the nodes. `--walltime 24:00` sets a walltime of 24 hours.  Adjust the walltime as needed.
* **`FLUX_NODE_FILE`:** Flux automatically creates a file containing the list of allocated nodes, accessible via the environment variable `$FLUX_NODE_FILE`. This replaces the need to manually create a hostfile.
* **Total Cores Calculation:** The comment clarifies the total number of cores requested (128).
* **`mpirun`:** The `mpirun` command is used to launch the application. The `-np` argument is set to the total number of cores (128).  The `--hostfile` argument is now `$FLUX_NODE_FILE`.
* **Environment Variables:** The environment variables are preserved.
* **Input Files:** The long string of input files is kept as is, enclosed in double quotes to handle spaces.
* **Removed Unnecessary Code:** The code to create the hostfile and calculate the number of DCUs is removed, as Flux handles node allocation and provides the node list automatically.
* **Walltime:** Added a walltime to the flux request.
* **Clarity and Comments:** Added comments to explain the purpose of each section.

This revised script is a more accurate and efficient translation of the original Slurm script to Flux.  It leverages Flux's features for resource allocation and simplifies the overall process.  Remember to adjust the walltime and other parameters as needed for your specific worklo