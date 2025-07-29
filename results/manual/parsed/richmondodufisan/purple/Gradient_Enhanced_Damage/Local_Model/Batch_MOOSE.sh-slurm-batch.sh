#!/bin/bash
#FLUX: --job-name=Local_Grad_Enhance
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --urgency=16

script_name="LOCAL_Three_Point_Bending_Test.i"
module purge
module use /software/spack_v20d1/spack/share/spack/modules/linux-rhel7-x86_64/
module load singularity
module load mpi/mpich-4.0.2-gcc-10.4.0
mpiexec -np ${SLURM_NTASKS} singularity exec -B /projects:/projects -B /scratch:/scratch -B /projects/p32089/singularity/moose/moose:/opt/moose /projects/p32089/singularity/moose_latest.sif /projects/p32089/MOOSE_Applications/purple/purple-opt -i ${script_name}
