#!/bin/bash

#FLUX: --job-name=Act_tanh_1
#FLUX: --output=/work/scratch/se55gyhe/log/output.out.%J
#FLUX: --error=/work/scratch/se55gyhe/log/output.err.%J

# Resource requests
#FLUX: -N 1                                 # Number of nodes (implied 1 for a single small task)
#FLUX: -n 1                                 # Number of tasks
#FLUX: -c 1                                 # Number of CPUs per task
#FLUX: --requires=mem=6000M                 # Memory required per task (6000MB in this case for 1 task on 1 CPU)
#FLUX: --time-limit=23h59m0s                # Walltime in hours, minutes, seconds

# Original script had mail notifications, Flux handles notifications differently (e.g., via event system or flux job attach).
# #SBATCH --mail-user=eger@ukp.informatik.tu-darmstadt.de
# #SBATCH --mail-type=FAIL

# Original commented-out module load line
#module load intel python/3.5

# Execute the application
python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.1_8 odd_G2P_1_8/