#!/bin/bash
#FLUX: --job-name=build_dataset
#FLUX: -c=40
#FLUX: -t=600
#FLUX: --urgency=16

export PYTHONPATH='${HOME}/DINAE_keras/:${HOME}/PB_ANDA:${PYTHONPATH}:${HOME}/4DVARNN-DinAE:${HOME}/NATL60:/gpfswork/rech/yrf/uba22to/esmf/esmpy/lib/python3.7/site-packages:/gpfswork/rech/yrf/uba22to/esmf/xesmf/lib/python3.7/site-packages'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/gpfswork/rech/yrf/uba22to/esmf/lib/libO/Linux.intel.64.openmpi.default'

module purge
module load tensorflow-gpu/py3/1.14-openmpi
module load geos/3.7.3
module load netcdf-fortran/4.5.3-mpi-cuda netcdf-c/4.7.4-mpi-cuda parallel-netcdf/1.12.1-mpi-cuda
export PYTHONPATH=${HOME}/DINAE_keras/:${HOME}/PB_ANDA:${PYTHONPATH}:${HOME}/4DVARNN-DinAE:${HOME}/NATL60:/gpfswork/rech/yrf/uba22to/esmf/esmpy/lib/python3.7/site-packages:/gpfswork/rech/yrf/uba22to/esmf/xesmf/lib/python3.7/site-packages
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/gpfswork/rech/yrf/uba22to/esmf/lib/libO/Linux.intel.64.openmpi.default
set -x
cd /linkhome/rech/genimt01/uba22to/NATL60/src
python -u create_mask.py $1
