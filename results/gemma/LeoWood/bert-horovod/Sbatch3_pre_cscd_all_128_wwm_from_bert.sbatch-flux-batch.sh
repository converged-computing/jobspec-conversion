# Flux batch script

# Resources
# Total nodes: 4
# Tasks per node: 4
# CPUs per task: 8
# GPUs per node: 4 (total 16)

# Flux options
--nodes=4
--gpus=16
--cpus-per-task=8

# Environment variables
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Application command
mpirun -np 64 -mca pml ucx -x UCX_TLS=sm,rc,rocm_cpy,rocm_gdr,rocm_ipc -x LD_LIBRARY_PATH -mca coll_hcoll_enable 0 --bind-to none \
    python run_pretraining_hvd.py \
    --input_file /work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_O_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_S_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TF_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TK_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TP_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TV_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_P_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TB_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TG_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TL_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TQ_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_U_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_Q_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TD_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TH_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TM_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TS_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_V_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_R_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TE_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TJ_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TN_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TU_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_X_cscd_128_wwm_cmesh.tfrecord \
    --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --init_checkpoint /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_model.ckpt \
    --output_dir /work1/zzx6320/lh/Projects/bert/outputs/Pre3_cscd_all_128_64_from_bert \
    --max_seq_length 128 \
    --do_train True \
    --do_eval True \
    --train_batch_size 64 \
    --learning_rate 2e-5 \
    --num_train_steps 3000000 \
    --save_checkpoints_steps 1000
```
Key changes and explanations:

*   **Job Manager Identification:** The script clearly uses Slurm directives (`#SBATCH`).
*   **Resource Translation:**  Flux uses `--nodes`, `--gpus`, and `--cpus-per-task` for resource requests.  The original script requested 4 nodes, 4 tasks per node, and 8 cpus per task, and 4 GPUs per node.  This translates to `--nodes=4`, `--gpus=16`, and `--cpus-per-task=8`.  The total number of MPI ranks is calculated as nodes * tasks_per_node = 4 * 4 = 16.
*   **Hostfile Handling:** The Slurm script generated a hostfile. Flux handles node allocation internally, so the hostfile generation and usage are removed.
*   **Environment Variables:** Environment variables are directly exported in the Flux script.
*   **MPI Command:** The `mpirun` command is kept largely the same, as Flux is compatible with `mpirun`.
*   **Removed Slurm Directives:** All `#SBATCH` directives are removed.
*   **Complexity:** The original script's complexity is relatively high due to the hostfile manipulation and numerous environment variables. The Flux script simplifies this, reducing the complexity slightly.
*   **Input Files:** The long string of input files is kept as is, as it's part of the application's arguments and not related to the job scheduler.
*   **No Walltime:**  Flux doesn't have a direct equivalent to Slurm's `--time` or walltime.  Walltime is typically managed by the system administrator or through Flux's resource limits.  If a specific walltime is required, it would need to be configured separate