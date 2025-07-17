#!/bin/bash
#FLUX: --job-name=resp_postproc
#FLUX: --queue=bigmem
#FLUX: -t=5400
#FLUX: --urgency=16

export LAUNCHER_WORKDIR='/cluster/projects/nn9464k/fabio/OSCAR_response_results/641159/data'
export LD_LIBRARY_PATH='/cluster/home/fabiobz/progs/xerces-c-3.2.3/install/lib:$LD_LIBRARY_PATH'

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
export LAUNCHER_WORKDIR=/cluster/projects/nn9464k/fabio/OSCAR_response_results/641159/data
module load Python/3.8.2-GCCcore-9.3.0 ROOT/6.12.06-intel-2018a-Python-2.7.14 icc/2019.1.144-GCC-8.2.0-2.31.1 CMake/3.13.3-GCCcore-8.2.0
export LD_LIBRARY_PATH=/cluster/home/fabiobz/progs/xerces-c-3.2.3/install/lib:$LD_LIBRARY_PATH
source /cluster/home/fabiobz/progs/geant4.10.06.p02-install/bin/geant4.sh
module list 
cd $LAUNCHER_WORKDIR
root -l export_hist_short.C
