#!/bin/bash
#FLUX: --job-name=mhd_run
#FLUX: -n=144
#FLUX: --queue=general
#FLUX: -t=259200
#FLUX: --priority=16

module purge > /dev/null 2>&1
module load wulver
module load foss/2022b
module use /opt/site/easybuild/modules/all/Core
make
srun mhd_run
