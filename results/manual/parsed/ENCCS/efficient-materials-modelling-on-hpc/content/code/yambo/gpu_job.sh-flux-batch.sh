#!/bin/bash
#FLUX: --job-name=mos2-test
#FLUX: -c=64
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='8'

module purge
module use /ceph/hpc/data/d2021-135-users/modules
module load YAMBO/5.1.1-OMPI-4.0.5-NVHPC-21.2-CUDA-11.2.1
export OMP_NUM_THREADS=8
srun --mpi=pmix -n ${SLURM_NTASKS} yambo -F gw.in -J GW_dbs -C GW_reports
