#!/bin/bash
#FLUX: --job-name=reorder
#FLUX: --queue=largemem
#FLUX: -t=36000
#FLUX: --urgency=16

export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
ibrun ./tdu 64-1.0r/64-1.5r.mesh
