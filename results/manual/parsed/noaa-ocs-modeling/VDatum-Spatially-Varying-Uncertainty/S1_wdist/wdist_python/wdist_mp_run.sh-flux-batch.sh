#!/bin/bash
#FLUX: --job-name=HPL
#FLUX: --queue=tjet,ujet,sjet,vjet,xjet,kjet
#FLUX: -t=10800
#FLUX: --priority=16

date
echo "host name is `hostname` : $SLURM_ARRAY_TASK_ID gages_ids_nodes.txt fort.14"
cp   ../TXstabilize/fort.14 tt/${SLURM_ARRAY_TASK_ID}.fort.14
cp   gages_ids_nodes.txt tt/${SLURM_ARRAY_TASK_ID}.gages.txt
./wdist.py $SLURM_ARRAY_TASK_ID tt/${SLURM_ARRAY_TASK_ID}.gages.txt tt/${SLURM_ARRAY_TASK_ID}.fort.14
date
