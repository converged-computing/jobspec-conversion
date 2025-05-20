# Flux batch script

# Request resources
# Flux uses a single --nproc argument for total processes.
# We need to calculate this from the original script.
# Original script: 4 nodes * 4 tasks/node * 8 cpus/task = 128 cpus
# Original script: 4 nodes * 4 GPUs/node = 16 GPUs
# Flux doesn't directly map to DCU, so we'll request GPUs.

--nproc=128
--gpu=4
--time=72:00:00  # Assuming a reasonable walltime, adjust as needed.  Slurm script didn't specify.

# Set environment variables
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Run the application
mpirun -mca pml ucx -x UCX_TLS=sm,rc,rocm_cpy,rocm_gdr,rocm_ipc -x LD_LIBRARY_PATH -mca coll_hcoll_enable 0 --bind-to none \
    python run_pretraining_hvd.py \
    --input_file /public/home/zzx6320/lh/Projects/bert/data/cscibert_pre_training/pre_training_R_cscd_128.tfrecord \
    --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --init_checkpoint /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_model.ckpt \
    --output_dir output/Pre2_cscd_R_128_64_from_bert \
    --max_seq_length 128 \
    --do_train True \
    --do_eval True \
    --train_batch_size 64 \
    --learning_rate 2e-5 \
    --num_train_steps 500000 \
    --save_checkpoints_steps 1000
```
Key improvements and explanations:

* **JSON Metadata:**  Provides a clear summary of the original script's characteristics.
* **Flux Resource Requests:**  Flux uses `--nproc` for the total number of processes.  The original script requested 4 nodes * 4 tasks/node * 8 cpus/task = 128 cpus.  We translate this to `--nproc=128`.  The `--gpu=4` request is used to request the 4 GPUs.  I've added a `--time` argument with a default value; you *must* adjust this to a suitable walltime for your job.
* **Removed Hostfile Generation:** Flux handles node allocation internally. The hostfile generation and manipulation are unnecessary and removed.
* **Environment Variables:**  The environment variables are preserved.
* **Command Preservation:** The `mpirun` command and its arguments are kept as they are, as they are likely necessary for the application's functionality.
* **Comments:** Added comments to explain the translation process.
* **Corrected GPU Request:**  Flux uses `--gpu` to request GPUs.
* **Walltime:** Added a `--time` argument, which is crucial for Flux jobs.  The value (72:00:00) is a placeholder; *you must change this to the appropriate walltime for your job*.
* **Simplified Script:** Removed unnecessary parts of the original script that are handled automatically by Flux.
* **Clarity and Readability:** Improved the overall formatting and readability of the Flux scri