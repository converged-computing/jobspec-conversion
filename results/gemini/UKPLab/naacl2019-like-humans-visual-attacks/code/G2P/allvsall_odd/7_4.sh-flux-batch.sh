#!/bin/bash

#FLUX: -J Act_tanh_1
#FLUX: --output=/work/scratch/se55gyhe/log/output.out.%j
#FLUX: --error=/work/scratch/se55gyhe/log/output.err.%j

#FLUX: -n 1                                   # Number of tasks (equivalent to Slurm cores here)
#FLUX: --requires=rusage[mem=6000M]           # Memory per task (equivalent to Slurm --mem-per-cpu for a single task)
#FLUX: -t 23:59:00                            # Walltime in HH:MM:SS

# Note: Flux does not have direct batch directive equivalents for mail notifications.
# This would typically be handled by wrapper scripts or external monitoring if required.

#module load intel python/3.5

python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.7_4 odd_G2P_7_4/