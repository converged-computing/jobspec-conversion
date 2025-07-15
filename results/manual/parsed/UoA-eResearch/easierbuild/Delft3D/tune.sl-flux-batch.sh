#!/bin/bash
#FLUX: --job-name=angry-latke-4284
#FLUX: -t=18000
#FLUX: --urgency=16

export I_MPI_FABRICS='shm:dapl'
export LANG='C'
export LC_ALL='C'
export LC_CTYPE='C'

ml Python/3.4.3-intel-2015a
ml VTune/2015_update2
ml Delft3D/5128-intel-2015a
ml impi/5.0.3.048-iccifort-2015.2.164-GCC-4.9.2
ml itac/9.0.3.051
source itacvars.sh impi5
unset I_MPI_PMI_LIBRARY #required
export I_MPI_FABRICS=shm:dapl
export LANG=C
export LC_ALL=C
export LC_CTYPE=C
mpitune -a \"mpiexec.hydra d_hydro.exe config_d_hydro.xml\" -of tune.conf 
