#!/bin/bash
#FLUX: --job-name=creamy-diablo-9943
#FLUX: -c=8
#FLUX: --urgency=16

module load nvhpc/22.3 
echo $HOSTNAME > hostname.dat
./application_name  > out.4096.C.$SLURM_JOBID.dat
