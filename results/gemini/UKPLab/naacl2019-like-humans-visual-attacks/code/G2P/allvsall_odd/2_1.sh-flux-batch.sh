#!/bin/bash

#FLUX: --job-name=Act_tanh_1
#FLUX: --output=/work/scratch/se55gyhe/log/output.out.%J
#FLUX: --error=/work/scratch/se55gyhe/log/output.err.%J
#FLUX: -N 1                    # Number of nodes (job will run on a single node)
#FLUX: -n 1                    # Total number of tasks for the job
#FLUX: --cores-per-task=1      # Number of cores per task
#FLUX: --R=rusage[mem=6000M]   # Memory request per task (6000MB)
#FLUX: --time-limit=23:59:00   # Walltime in HH:MM:SS

# Note: Slurm's --mail-user and --mail-type options do not have direct
# equivalents as Flux script directives. Mail notifications would typically
# be handled by external mechanisms or wrapper scripts in a Flux environment.

#module load intel python/3.5 # This was commented out in the original script

python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.2_1 odd_G2P_2_1/