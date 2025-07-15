#!/bin/bash
#FLUX: --job-name=grated-underoos-0396
#FLUX: -c=4
#FLUX: -t=21600
#FLUX: --priority=16

srun eb  GROMACS-4.6.5-ictce-5.5.0-mt.eb --try-toolchain=ictce,5.4.0 --robot --force
srun eb WRF-3.4-goalf-1.1.0-no-OFED-dmpar.eb -r
/sNow/apps/lmod/utils/BuildSystemCacheFile/createSystemCacheFile.sh
