#!/bin/bash

# Flux directives translated from Slurm's #SBATCH

# Job Name
#SBATCH -J Act_tanh_1
#flux: -J Act_tanh_1

# Standard output and error files
#SBATCH -o /work/scratch/se55gyhe/log/output.out.%j
#flux: --output=/work/scratch/se55gyhe/log/output.out.%j
#SBATCH -e /work/scratch/se55gyhe/log/output.err.%j
#flux: --error=/work/scratch/se55gyhe/log/output.err.%j

# Resource requests:
# Slurm: -n 1 (Number of tasks, implicitly 1 core per task if --cpus-per-task is not set)
# Slurm: --mem-per-cpu=6000 (Memory per CPU)
# Slurm: -t 23:59:00 (Walltime)

# Flux translation:
# Request 1 task, with 1 core assigned to this task.
# Total memory for the job will be 6000MB.
# Walltime in HhMmSs format.
#flux: -n 1                   # Number of tasks
#flux: --cores-per-task=1     # Number of cores per task
#flux: --mem=6000M            # Total memory for the job (1 task * 1 core/task * 6000MB/core)
#flux: -t 23h59m00s           # Walltime

# Mail notification options from Slurm are not directly translated as Flux typically
# handles notifications at the instance or site level, not via job script directives.
#SBATCH --mail-user=eger@ukp.informatik.tu-darmstadt.de
#SBATCH --mail-type=FAIL

# Original commented module load:
# module load intel python/3.5
# If this module is required for 'python3', it should be uncommented and
# ensured it's available in the Flux environment, or an equivalent module should be loaded.

# The main command to be executed
python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.7_0 odd_G2P_7_0/