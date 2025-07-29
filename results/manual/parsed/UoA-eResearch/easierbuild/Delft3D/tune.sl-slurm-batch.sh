#!/bin/bash
#SBATCH --job-name=TUNE
#SBATCH --account=uoa00035
#SBATCH --output=stdout.txt
#SBATCH --error=stderr.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2048
#SBATCH --time=05:00:00

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
