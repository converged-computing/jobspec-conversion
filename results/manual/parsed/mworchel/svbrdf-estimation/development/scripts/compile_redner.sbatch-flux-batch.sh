#!/bin/bash
#FLUX: --job-name=RednerCompilation
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load cmake/3.16.3
module load comp/gcc/7.2.0
module load nvidia/cuda/10.0
echo $PWD
echo "Entering working directory"
cd ~/redner
echo $PWD
source activate redner-build-env
echo "Building redner"
python -u -m pip wheel -w dist --verbose .
exitCode=$?
echo "Finished building (exit code $exitCode)"
conda deactivate
exit $exitCode
