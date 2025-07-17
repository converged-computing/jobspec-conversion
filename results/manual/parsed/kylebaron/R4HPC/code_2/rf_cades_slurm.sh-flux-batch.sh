#!/bin/bash
#FLUX: --job-name=rf
#FLUX: -c=32
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

export MODULEPATH='/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core'

cd ~/R4HPC/code_2
pwd
source /software/cades-open/spack-envs/base/root/linux-centos7-x86_64/gcc-6.3.0/lmod-8.5.6-wdngv4jylfvg2j6jt7xrtugxggh5lpm5/lmod/lmod/init/bash
export MODULEPATH=/software/cades-open/spack-envs/base/modules/site/Core:/software/cades-open/modulefiles/core
module load gcc
module load openmpi
module load r/4.1.0-py3-X
echo "loaded R"
module list
time Rscript rf_serial.r
time Rscript rf_mc.r --args 1
time Rscript rf_mc.r --args 2
time Rscript rf_mc.r --args 4
time Rscript rf_mc.r --args 8
time Rscript rf_mc.r --args 16
time Rscript rf_mc.r --args 32
time Rscript rf_mc.r --args 64
