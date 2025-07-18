#!/bin/bash
#FLUX: --job-name=ISO
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

export PMIX_MCA_gds='hash'
export LD_LIBRARY_PATH='\$LD_LIBRARY_PATH:${HOME}/local/lib64'

ulimit -s unlimited
ulimit -c unlimited
ulimit -v unlimited
export PMIX_MCA_gds=hash
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:${HOME}/local/lib64
cd $PWD
module load python-3.9.15-gcc-9.4.0-f466wuv
source .venv/bin/activate
./test.sh
