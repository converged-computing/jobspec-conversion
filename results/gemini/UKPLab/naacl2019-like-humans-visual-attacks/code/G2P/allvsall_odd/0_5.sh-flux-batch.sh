#!/bin/bash

#FLUX: --job-name=Act_tanh_1
#FLUX: --output=/work/scratch/se55gyhe/log/output.out.%J
#FLUX: --error=/work/scratch/se55gyhe/log/output.err.%J

# Resource requests:
# Original Slurm script requested:
# - 1 task (#SBATCH -n 1), which defaults to 1 CPU per task.
# - 6000MB of memory per CPU (#SBATCH --mem-per-cpu=6000).
# - Walltime of 23 hours, 59 minutes (#SBATCH -t 23:59:00).

# Flux translation:
#FLUX: -n 1                                 # Number of tasks
#FLUX: -c 1                                 # Number of CPU cores per task
#FLUX: --mem-per-cpu=6000M                  # Memory per CPU (M for Megabytes)
#FLUX: -t 23h59m0s                          # Walltime in HHhMMmSSs format

# Note on mail notifications:
# The Slurm directives #SBATCH --mail-user and #SBATCH --mail-type do not have
# direct equivalents as Flux script directives. Mail notifications in Flux
# are typically handled externally, e.g., using 'flux job attach --events'
# after submission or through wrapper scripts.

# Environment setup:
# The original script had a commented-out module load command.
# Assuming it's required for the Python script, it's uncommented here.
# If python3 is already in the path and no specific intel-optimized libraries
# are needed by this python script, this line might be adjusted or removed.
module load intel python/3.5

# Execute the application
python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.0_5 odd_G2P_0_5/