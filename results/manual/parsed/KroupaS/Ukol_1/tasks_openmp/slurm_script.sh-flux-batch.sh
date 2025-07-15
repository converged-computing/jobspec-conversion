#!/bin/bash
#FLUX: --job-name=my_mpi_program
#FLUX: --urgency=16

source /etc/profile.d/zz-cray-pe.sh
srun ./vps.out in_0001.txt -s 48
exit 0
