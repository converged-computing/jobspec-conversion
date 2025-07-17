#!/bin/bash
#FLUX: --job-name=__jobName
#FLUX: -N=4
#FLUX: --queue=batch
#FLUX: -t=18000
#FLUX: --urgency=16

machine="IBEX" # HPC or IBEX
if [[ $machine == "IBEX" ]]; then
    module load  lammps/29Sep2021/openmpi-4.0.3_intel2020
    export LMP_CMD="/sw/csi/lammps/29Sep2021/openmpi-4.0.3_intel2020/install/bin/lmp_ibex"
    export OMP_NUM_THREADS=1
    export SLURM_NPROCS=96
elif [[ $machine == "HPC" ]]; then
    export LMP_CMD="replace-it-with-lmp-executable"
    export OMP_NUM_THREADS=1
    export SLURM_NPROCS=24
fi
echo """
      SLURM_JOB_ID: ${SLURM_JOB_ID}
SLURM_JOB_NODELIST: ${SLURM_JOB_NODELIST}
      SLURM_NPROCS: ${SLURM_NPROCS}
"""
mpirun -np ${SLURM_NPROCS} ${LMP_CMD} -in INCAR.lmp
