#!/bin/bash
#FLUX: --job-name=boopy-signal-9862
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

export MPLCONFIGDIR='../mpl'

                                         # REMEMBER TO CHANGE X DEPENDING ON THE PARAMETERS TO SWEEP
export MPLCONFIGDIR=../mpl
source ./ttt/bin/activate
readarray -t parameters < ./param_file_eps_Nsymm_rand_y.txt
/usr/bin/time -f "\t%E real,\t%M kb MaxMem" /home/frarzani/pqc-symmetry/ttt/bin/python3 -u run_ttt.py ${parameters[$SLURM_ARRAY_TASK_ID]}
