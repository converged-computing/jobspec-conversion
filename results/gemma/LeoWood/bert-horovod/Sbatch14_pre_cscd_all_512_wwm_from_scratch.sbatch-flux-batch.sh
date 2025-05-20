# Flux batch script

# Resources
# Total cores: 4 nodes * 4 cores/node * 8 cpus/task = 128 cores
# Total GPUs: 4 nodes * 4 GPUs/node = 16 GPUs

# Flux options
--nodes=4
--gpus=16
--cores=128
--time=72:00:00  # Assuming a reasonable walltime, adjust as needed

# Environment setup
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Input files (long string, can be shortened if needed)
input_files="/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_O_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_S_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TF_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TK_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TP_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TV_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_P_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TB_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TG_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TL_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TQ_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_U_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_Q_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TD_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TH_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TM_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TS_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_V_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_R_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TE_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TJ_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TN_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_TU_cscd_512_wwm_cmesh.tfrecord,/work1/zzx6320/lh/Projects/bert/data/cscd_all_wwm/pre_training_X_cscd_512_wwm_cmesh.tfrecord"

# Command to run
mpirun -np 128 --oversubscribe=false -mca pml ucx -x UCX_TLS=sm,rc,rocm_cpy,rocm_gdr,rocm_ipc -x LD_LIBRARY_PATH -mca coll_hcoll_enable 0 --bind-to none \
    python run_pretraining_hvd.py \
    --input_file "${input_files}" \
    --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --output_dir /work1/zzx6320/lh/Projects/bert/outputs/Pre14_cscd_all_512_64_from_scratch \
    --max_seq_length 512 \
    --do_train True \
    --do_eval True \
    --train_batch_size 10 \
    --learning_rate 2e-5 \
    --num_train_steps 2000000 \
    --save_checkpoints_steps 1000
```
Key changes and explanations:

*   **Job Manager Identification:** The original script uses `#SBATCH` directives, clearly indicating **Slurm** as the job manager.
*   **Resource Requests:**  Slurm's `--ntasks-per-node` and `--cpus-per-task` are combined to determine the total number of cores.  The `--gres=dcu:4` is translated to `--gpus=16` (4 nodes * 4 GPUs/node).  Flux uses `--nodes`, `--gpus`, `--cores`, and `--time` for resource requests.  I've added a `--time` estimate; you should adjust this based on the expected runtime.
*   **Hostfile Generation:** The Slurm script generates a hostfile. Flux doesn't require this; it handles node allocation internally.  The hostfile-related code is removed.
*   **MPI Run:** The `mpirun` command is largely preserved, but `--oversubscribe=false` is added to Flux to prevent oversubscription of cores.
*   **Environment Variables:** The environment variable settings are carried over directly.
*   **Input Files:** The long string of input files is passed as a single variable to the python script.
*   **Complexity:** The original script's complexity is moderate (7/10) due to the resource requests, environment setup, and the length of the command. The Flux script is slightly simpler because it removes the hostfile generation.
*   **Flux Syntax:** The script is formatted using Flux's command-line options.  The `--` prefix is used for options.
*   **Quotes:**  I've added quotes around the `input_files` variable to handle spaces in the file paths.

This translation aims to be as accurate as possible, but you should always test the Flux script thoroughly to ensure it behaves as expected in your environment.  Adjust the `--time` parameter and other options as need