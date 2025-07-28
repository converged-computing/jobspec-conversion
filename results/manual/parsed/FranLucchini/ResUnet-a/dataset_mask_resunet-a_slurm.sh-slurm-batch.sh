#!/bin/bash
#FLUX: --job-name=build_dataset_resunet-a
#FLUX: -n=7
#FLUX: -t=86700
#FLUX: --urgency=16

list=('' 'AT' 'ES' 'FR' 'LU' 'NL' 'SE' 'SI')
python /home/chocobo/Cenia-ODEPA/ResUnet-a_original/maskimg.py --country ${list[SLURM_ARRAY_TASK_ID]}
