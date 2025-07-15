#!/bin/bash
#FLUX: --job-name=sticky-milkshake-0085
#FLUX: -c=8
#FLUX: --priority=16

module load nvhpc/22.3 
echo $HOSTNAME > hostname.dat
./application_name  > out.4096.C.$SLURM_JOBID.dat
