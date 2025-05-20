#!/bin/bash

#flux: version=1

# Job name
#flux: job-name=Act_tanh_1

# Output and error files
#flux: output=/work/scratch/se55gyhe/log/output.out.%j
#flux: error=/work/scratch/se55gyhe/log/output.err.%j

# Resource requests
#flux: -n 1                   # Number of tasks (Slurm -n 1, implies 1 core for the task)
#flux: --requires=mem=6000M   # Total memory for the job (derived from Slurm --mem-per-cpu=6000 for 1 core)
#flux: -t 23:59:00            # Walltime (HH:MM:SS)

# Note on mail notifications:
# The original Slurm script requested email notifications:
# #SBATCH --mail-user=eger@ukp.informatik.tu-darmstadt.de
# #SBATCH --mail-type=FAIL
# Flux typically handles email notifications via options to `flux job attach`
# (e.g., --mail-user, --mail-type) or through system-level configuration,
# rather than in-script directives.

# Note on software modules:
# The original script had a commented-out module load command:
# #module load intel python/3.5
# If these modules are needed, they should be loaded here.
# For example:
# module load intel python/3.5

# Execute the application
python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.3_0 odd_G2P_3_0/