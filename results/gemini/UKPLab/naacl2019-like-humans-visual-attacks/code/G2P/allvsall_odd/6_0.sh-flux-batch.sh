#!/bin/bash

#FLUX: --job-name=Act_tanh_1
#FLUX: --output=/work/scratch/se55gyhe/log/output.out.{id}
#FLUX: --error=/work/scratch/se55gyhe/log/output.err.{id}

# Original Slurm resource requests:
# -n 1 (1 core/task)
# --mem-per-cpu=6000 (6000MB for that core)
# -t 23:59:00 (walltime)

# Equivalent Flux resource requests:
# Request 1 node
#FLUX: -N 1
# Request 1 task in total for the job
#FLUX: -n 1
# Request 1 CPU core for that task
#FLUX: --cpus-per-task=1
# Request 6000MB of memory for the job (which this single task will use)
#FLUX: --mem=6000M
# Explicitly request no GPUs, as none were requested in the original script
#FLUX: --gpus-per-task=0

# Set the walltime limit
#FLUX: --time-limit=23:59:00

# Note: Mail notification options (--mail-user, --mail-type) from Slurm
# do not have direct equivalents in Flux batch directives and are omitted.
# Flux users typically use `flux job attach --events` or other monitoring tools.

# Original script had a commented module load line:
#module load intel python/3.5

# The main application command
python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.6_0 odd_G2P_6_0/