#!/bin/bash

# Flux directives
# Request 4 nodes
#FLUX: -N 4
# Request a total of 16 tasks (4 nodes * 4 tasks/node from original)
#FLUX: -n 16
# Request a total of 16 GPUs (4 nodes * 4 GPUs/node from original)
#FLUX: --gpus=16
# Set the job name
#FLUX: --job-name="pre_scrach"
# Set the output file
#FLUX: --output="pre_cscd_r_128_from_scrach.out"
# Optionally, set the error file
#FLUX: --error="pre_cscd_r_128_from_scrach.err"
# Optionally, specify the queue/partition if applicable in Flux
#FLUX: -q normal

# Environment variables from the original script
export MIOPEN_USER_DB_PATH=/tmp/tensorflow-miopen-${USER}-2.8
export MIOPEN_DEBUG_DISABLE_FIND_DB=1
export HOROVOD_HIERARCHICAL_ALLREDUCE=1

# Environment variables derived from mpirun options
# for UCX
export UCX_TLS="sm,rc,rocm_cpy,rocm_gdr,rocm_ipc"
# for OpenMPI MCA parameters
export OMPI_MCA_pml="ucx"
export OMPI_MCA_coll_hcoll_enable="0"

# The LD_LIBRARY_PATH is typically propagated by Flux if set in the submission environment.
# If it needs to be explicitly set or modified in the script, do it here:
# export LD_LIBRARY_PATH=/new/path:${LD_LIBRARY_PATH}

# Execute the application using flux run
# -n 16: run 16 tasks in total
# --cores-per-task=8: assign 8 CPU cores to each task
# --gpus-per-task=1: assign 1 GPU to each task
# --tasks-per-node=4: distribute 4 tasks onto each of the 4 nodes
# --cpu-affinity=off: equivalent to mpirun's --bind-to none
# Flux will distribute the 16 tasks, ensuring each gets 8 cores and 1 GPU.
# With -N 4 in allocation and -n 16, this implies 4 tasks per node.
# The --tasks-per-node=4 option for flux run makes this explicit.
flux run -n 16 --cores-per-task=8 --gpus-per-task=1 --tasks-per-node=4 --cpu-affinity=off \
    python run_pretraining_hvd.py \
    --input_file /public/home/zzx6320/lh/Projects/bert/data/cscibert_pre_training/pre_training_R_cscd_128.tfrecord \
    --bert_config_file /public/home/zzx6320/lh/Projects/bert/models/chinese_L-12_H-768_A-12/chinese_L-12_H-768_A-12/bert_config.json \
    --output_dir output/Pre1_cscd_R_128_64_from_scrach \
    --max_seq_length 128 \
    --do_train True \
    --do_