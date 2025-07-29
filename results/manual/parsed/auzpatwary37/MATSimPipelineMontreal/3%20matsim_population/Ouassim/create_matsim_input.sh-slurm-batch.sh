#!/bin/bash
#FLUX: --job-name=10per
#FLUX: -c=30
#FLUX: -t=36000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$EBROOTGEOS/lib # Add the path to GEOS libraries'
export SPATIALINDEX_C_LIBRARY='/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/Compiler/gcc7.3/libspatialindex/1.8.5/lib/libspatialindex_c.so.4'

module load gdal geos proj
export LD_LIBRARY_PATH=$EBROOTGEOS/lib # Add the path to GEOS libraries
export SPATIALINDEX_C_LIBRARY="/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/Compiler/gcc7.3/libspatialindex/1.8.5/lib/libspatialindex_c.so.4"
module load java/1.8.0_192 maven
echo "Prepare running environment"
source /scratch/omanout/matsim_input/matsim_python_env/bin/activate
echo "Prepare the git code"
cd /scratch/omanout/matsim_input/matsim_quebec_province
echo "Running MATSIM"
python run.py
