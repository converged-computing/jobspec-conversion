#!/bin/bash

#FLUX -J Act_tanh_1
#FLUX --mail-user=eger@ukp.informatik.tu-darmstadt.de
#FLUX --mail-type=FAIL
#FLUX -e /work/scratch/se55gyhe/log/output.err.%J
#FLUX -o /work/scratch/se55gyhe/log/output.out.%J

#FLUX -n 1                  # Number of tasks (equivalent to Slurm -n)
#FLUX -c 1                  # Number of cpus per task (explicitly 1)
#FLUX --mem-per-cpu=6000M   # Memory per CPU
#FLUX -t 23:59:00           # Walltime (Hours, minutes and seconds)

#module load intel python/3.5

python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.9_0 odd_G2P_9_0/