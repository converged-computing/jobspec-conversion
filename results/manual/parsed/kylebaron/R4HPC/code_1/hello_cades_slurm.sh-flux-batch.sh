#!/bin/bash
#FLUX: --job-name=loopy-cinnamonbun-6745
#FLUX: -N=4
#FLUX: --priority=16

export MODULEPATH='/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core'

cd ~/R4HPC/code_1
pwd
source /software/cades-open/spack-envs/base/root/linux-centos7-x86_64/gcc-6.3.0/lmod-8.5.6-wdngv4jylfvg2j6jt7xrtugxggh5lpm5/lmod/lmod/init/bash
export MODULEPATH=/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core
module load gcc
module load openmpi
module load r/4.1.0-py3-X-flexiblas 
echo "loaded R with flexiblas"
module list
mpirun --map-by ppr:4:node Rscript hello_balance.R
