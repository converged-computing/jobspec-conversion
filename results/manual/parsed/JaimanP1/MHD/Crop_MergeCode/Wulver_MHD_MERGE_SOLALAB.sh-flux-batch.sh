#!/bin/bash
#FLUX: --job-name=mhd_merge
#FLUX: --queue=general
#FLUX: -t=259200
#FLUX: --urgency=16

module purge > /dev/null 2>&1
module load wulver
module load foss/2022b
module use /opt/site/easybuild/modules/all/Core
make
srun MergeCode
