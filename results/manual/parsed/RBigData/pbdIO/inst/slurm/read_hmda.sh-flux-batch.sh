#!/bin/bash
#FLUX: --job-name=hairy-peanut-8249
#FLUX: --exclusive
#FLUX: --urgency=16

export MODULEPATH='/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core'

source /software/cades-open/spack-envs/base/root/linux-centos7-x86_64/gcc-6.3.0/lmod-8.5.6-wdngv4jylfvg2j6jt7xrtugxggh5lpm5/lmod/lmod/init/bash
export MODULEPATH=/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core
module load gcc
module load openmpi
module load r/4.1.0-py3-X-flexiblas 
echo "loaded R with flexiblas"
module list
time mpirun --map-by ppr:1:socket Rscript read_hmda.r
time mpirun --map-by ppr:1:socket Rscript read_hmda.r
