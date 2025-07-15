#!/bin/bash
#FLUX: --job-name=gromacs-testB
#FLUX: -N=16
#FLUX: --queue=c5n-od
#FLUX: --urgency=16

export I_MPI_OFI_LIBRARY_INTERNAL='0'
export I_MPI_OFI_PROVIDER='efa'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export I_MPI_OFI_LIBRARY_INTERNAL=0
export I_MPI_OFI_PROVIDER=efa
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module purge
module load compiler/intel/2022.2.0 mpi/intel/2022.2.0 gromacs/v2021.4-intel-2022.2.0
cd Gromacs-TestCaseB
mpirun gmx_mpi mdrun -ntomp $OMP_NUM_THREADS -s benchRIB.tpr -resethway
