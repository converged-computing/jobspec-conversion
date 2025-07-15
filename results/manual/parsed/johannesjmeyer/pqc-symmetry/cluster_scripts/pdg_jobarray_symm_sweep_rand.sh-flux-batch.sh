#!/bin/bash
#FLUX: --job-name=phat-squidward-2383
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --urgency=16

export MPLCONFIGDIR='../mpl'

                                         # REMEMBER TO CHANGE X DEPENDING ON THE PARAMETERS TO SWEEP
export MPLCONFIGDIR=../mpl
source ./ttt/bin/activate
readarray -t parameters < ./param_file_pdg_symm_rand.txt
/usr/bin/time -f "\t%E real,\t%M kb MaxMem" /home/frarzani/pqc-symmetry/ttt/bin/python3 -u run_pdg.py ${parameters[$SLURM_ARRAY_TASK_ID]}
