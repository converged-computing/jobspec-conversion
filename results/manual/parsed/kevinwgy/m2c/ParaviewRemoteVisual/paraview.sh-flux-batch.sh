#!/bin/bash
#FLUX: --job-name=strawberry-nunchucks-6752
#FLUX: --priority=16

module load ParaView/5.9.1-foss-2021a-mpi
cd $SLURM_SUBMIT_DIR
mpirun -n 32 pvserver
exit;
