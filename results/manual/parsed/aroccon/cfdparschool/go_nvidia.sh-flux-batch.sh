#!/bin/bash
#FLUX: --job-name=goodbye-gato-7371
#FLUX: -c=8
#FLUX: --queue=g100_usr_interactive
#FLUX: -t=600
#FLUX: --urgency=16

module load nvhpc/22.3 
echo $HOSTNAME > hostname.dat
./application_name  > out.4096.C.$SLURM_JOBID.dat
