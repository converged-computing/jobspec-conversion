#!/bin/bash
#FLUX: --job-name=mymat
#FLUX: --queue=normal-mic
#FLUX: -t=1500
#FLUX: --urgency=16

export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

echo "Running on MIC and CPU"
export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
ibrun ./main < moldyn.in45 
