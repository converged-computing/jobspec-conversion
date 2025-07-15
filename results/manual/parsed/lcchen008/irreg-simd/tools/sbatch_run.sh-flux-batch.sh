#!/bin/bash
#FLUX: --job-name=fugly-house-2547
#FLUX: --urgency=16

export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
./main ../input/32-3.0r/32-3.0r.mesh.matlab 8192 
