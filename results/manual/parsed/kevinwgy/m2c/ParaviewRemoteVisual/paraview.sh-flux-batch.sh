#!/bin/bash
#FLUX --job-name=pusheena-butter-9072
#FLUX --queue=dev_q
#FLUX -t=10800
#FLUX --urgency=16

module load ParaView/5.9.1-foss-2021a-mpi
cd $SLURM_SUBMIT_DIR
mpirun -n 32 pvserver
exit;
