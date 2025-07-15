#!/bin/bash
#FLUX: --job-name=gassy-spoon-1479
#FLUX: --priority=16

module purge
module load intel/19.0.5-fasrc01
module load openmpi/4.0.1-fasrc01
module load netcdf-fortran/4.5.2-fasrc01
module load cmake/3.16.1-fasrc01
module list     # print loaded modules
set -e          # if a subsequent command fails, treat it as fatal (don't continue)
set -x          # for remainder of script, echo commands to the job's log file
ulimit -c 0                  # coredumpsize
ulimit -l unlimited          # memorylocked
ulimit -u 50000              # maxproc
ulimit -v unlimited          # vmemoryuse
ulimit -s unlimited          # stacksize
rm -f cap_restart                                # delete restart start time file if present
./runConfig.sh                                   # update configuration files
 srun -n 60 -N 2 -m plane=30 --mpi=pmix ./gchp   # launch 60 GCHP processes
