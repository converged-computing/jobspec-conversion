#!/bin/bash
#FLUX: --job-name=job_5
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='10'

export OMP_NUM_THREADS=10
cd $SLURM_SUBMIT_DIR
/opt/nvidia/hpc_sdk/Linux_x86_64/22.5/comm_libs/mpi/bin/mpirun /home/myless/VASP/vasp.6.3.2/bin/vasp_std
exit
