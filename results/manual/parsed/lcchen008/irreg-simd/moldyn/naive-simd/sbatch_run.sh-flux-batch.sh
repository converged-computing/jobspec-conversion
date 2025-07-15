#!/bin/bash
#FLUX: --job-name=joyous-poodle-8945
#FLUX: --priority=16

export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
./main ../../input/45-3.0r/45-3.0r.mesh ../../input/45-3.0r/45-3.0r.xyz
