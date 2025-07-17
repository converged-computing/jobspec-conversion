#!/bin/bash
#FLUX: --job-name=cbpm
#FLUX: -c=12
#FLUX: -t=3000
#FLUX: --urgency=16

cd /mmfs1/data/kurkela/Desktop/CamCan/code
module load matlab
matlab -nodisplay -nosplash -r "D_cbpm('memoryability', 'all', 'default', 0.01, 'none');"
