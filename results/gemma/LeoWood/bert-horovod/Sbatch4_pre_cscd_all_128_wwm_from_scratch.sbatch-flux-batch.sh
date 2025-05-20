# Flux batch script

# Resources
# Total nodes: 4
# Total tasks: 16 (4 nodes * 4 tasks/node)
# Total cores: 64 (4 nodes * 16 cores/node)
# Total GPUs: 16 (4 nodes * 4 GPUs/node)

# Flux options
--nodes=4
--gpus=16
--cores=64
--time=unknown  # Add walltime if known

# Environment variables
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Command to run
mpirun -np 64 --hostfile /tmp/hostfile -mca pml ucx -x UCX_TLS=sm,rc,rocm_cpy,rocm_gdr,rocm_ipc -x LD_LIBRARY_PATH -mca coll_hcoll_enable 0 --bind-to none \
    python run_pretraining_hvd.py \
    --input_file /work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_O_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_S_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TF_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TK_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TP_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TV_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_P_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TB_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TG_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TL_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TQ_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_U_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_Q_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TD_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TH_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TM_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TS_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_V_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_R_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TE_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TJ_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TN_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TU_cscd_128_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_X_cscd_128_wwm_cmesh.tfrecord \
    --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --output_dir /work1/zzx6320/lh/Projects/bert/outputs/Pre4_cscd_all_128_64_from_scratch \
    --max_seq_length 128 \
    --do_train True \
    --do_eval True \
    --train_batch_size 64 \
    --learning_rate 2e-5 \
    --num_train_steps 3000000 \
    --save_checkpoints_steps 1000
```
Key changes and explanations:

*   **Job Manager Identification:** The script uses `#SBATCH` directives, clearly indicating Slurm as the job manager.
*   **Resource Requests:**  Slurm requests are translated to Flux equivalents. `--nodes`, `--gpus`, and `--cores` are used.  The `--time` option is included but set to "unknown" as the original script doesn't specify a walltime.
*   **Hostfile:** The original script creates a hostfile. Flux handles node allocation internally, so the hostfile creation part is removed.  The `mpirun` command is updated to use `/tmp/hostfile` as the hostfile.
*   **Environment Variables:** Environment variables are preserved.
*   **Command:** The main command (`mpirun ... python ...`) is kept largely the same, but the `np` argument is updated to reflect the total number of cores requested (64).
*   **Complexity:** The original script is moderately complex due to the resource requests, environment setup, and the length of the command.  The Flux script is slightly simpler as Flux handles some of the resource management automatically.
*   **Removed Slurm-Specific Directives:** All `#SBATCH` directives are removed.
*   **Flux Syntax:** The script now uses the correct Flux command-line options.
*   **Input Files:** The long list of input files is preserved as