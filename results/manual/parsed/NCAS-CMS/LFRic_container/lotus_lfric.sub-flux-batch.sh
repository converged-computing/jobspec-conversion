#!/bin/bash
#FLUX: --job-name=strawberry-plant-4467
#FLUX: --urgency=16

export LOCAL_LD_LIBRARY_PATH='/apps/eb/software/OpenMPI/4.1.0-iccifort-2018.3.222-GCC-7.3.0-2.30/lib:\$LD_LIBRARY_PATH'
export BIND_OPT='-B /apps/eb'

module load eb/OpenMPI/intel/4.1.0 intel/20.0.0
cd <base_dir>/trunk/gungho/example
echo internal
time mpirun singularity exec <base_dir>/lfric_openmpi_env.sif ../bin/gungho configuration.nml
echo external
export LOCAL_LD_LIBRARY_PATH="/apps/eb/software/OpenMPI/4.1.0-iccifort-2018.3.222-GCC-7.3.0-2.30/lib:\$LD_LIBRARY_PATH"
export BIND_OPT="-B /apps/eb"
time mpirun singularity exec $BIND_OPT --env=LD_LIBRARY_PATH=$LOCAL_LD_LIBRARY_PATH <base_dir>/lfric_openmpi_env.sif ../bin/gungho configuration.nml
exit
