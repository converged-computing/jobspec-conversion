#!/bin/bash
#FLUX: --job-name=__job_name
#FLUX: -N=5
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

srcDIR=$(pwd)
machine="HPC" # HPC or IBEX
if [[ $machine == "IBEX" ]]; then
    module load  lammps/29Sep2021/openmpi-4.0.3_intel2020
    export LMP_CMD="/sw/csi/lammps/29Sep2021/openmpi-4.0.3_intel2020/install/bin/lmp_ibex"
    export OMP_NUM_THREADS=1
elif [[ $machine == "HPC" ]]; then
    # Test with care and HPC vasp is not compiled
    # with constrained relaxation functionality
    module purge
    module load openmpi/4.1.1/gcc-11.2.0-eaoyonl
    export LMP_CMD="${HOME}/Documents/applications/lammps/test/lammps-29Sep2021/src/lmp_mpi"
    # export OMP_NUM_THREADS=1
    export SLURM_NPROCS=24
fi
echo """
       JobId: ${SLURM_JOB_ID}
    NodeList: ${SLURM_JOB_NODELIST}
"""
mpirun -np ${SLURM_NPROCS} ${LMP_CMD} -in INCAR.lmp
