#!/bin/bash
#FLUX: --job-name="DOS"
#FLUX: -n=24
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --priority=16

export VASP_CMD='/ibex/scratch/jangira/vasp/sw/vasp.5.4.4/bin/vasp_std'
export OMP_NUM_THREADS='1'

srcDIR=$(pwd)
module load intel/2016
module load openmpi/4.0.3_intel
export VASP_CMD=/ibex/scratch/jangira/vasp/sw/vasp.5.4.4/bin/vasp_std
export OMP_NUM_THREADS=1
echo """
       JobId: ${SLURM_JOB_ID}
    NodeList: ${SLURM_JOB_NODELIST}
"""
mpirun -np ${SLURM_NPROCS} ${VASP_CMD}
