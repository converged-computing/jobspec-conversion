#!/bin/bash
#FLUX: --job-name=icon
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/sw/spack-levante/gcc-11.2.0-bcn7mb/lib64:$LD_LIBRARY_PATH'
export PREFIX='./build-nvhpc-acc'
export INPUT='20k.nc'

ulimit -s unlimited
ulimit -c 0
export LD_LIBRARY_PATH=/sw/spack-levante/gcc-11.2.0-bcn7mb/lib64:$LD_LIBRARY_PATH
export PREFIX=./build-nvhpc-acc
export INPUT="20k.nc"
cd /home/b/b382805/dx/icon-isc24
rm -f output.nc
echo "Profile run:"
module load nvhpc
nsys profile --trace=cuda,openacc --stats=true $PREFIX/bin/graupel ./tasks/$INPUT
echo "Actual run: "
$PREFIX/bin/graupel ./tasks/20k.nc
echo "Evaulate result: "
spack load cdo@2.2.2
cdo infon -sub output.nc reference_results/sequential_double_$INPUT
