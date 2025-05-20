#!/bin/bash

#FLUX: -J Act_tanh_1
#FLUX: -o /work/scratch/se55gyhe/log/output.out.%J
#FLUX: -e /work/scratch/se55gyhe/log/output.err.%J

# Resource requests:
# Original Slurm script requested 1 core with 6000MB of memory.
#FLUX: -N 1                     # Number of nodes
#FLUX: -n 1                     # Total number of tasks for the job
#FLUX: -c 1                     # Number of cores per task
#FLUX: --requires=mem=6000M     # Memory required for the job's allocation (6000 MiB)
#FLUX: -t 23:59:00              # Walltime in HH:MM:SS

# Note: Mail notification options (--mail-user, --mail-type) from Slurm
# are not directly translatable into Flux script directives.
# This functionality is typically handled by Flux instance configuration
# or external monitoring tools.

# Original script had a commented out module load:
# #module load intel python/3.5
# If this module is needed and available in the Flux environment,
# uncomment the following line:
# module load intel python/3.5

python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.4_4 odd_G2P_4_4/