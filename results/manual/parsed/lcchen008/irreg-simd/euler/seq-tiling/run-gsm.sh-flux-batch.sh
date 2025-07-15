#!/bin/bash
#FLUX: --job-name=anxious-dog-0413
#FLUX: --urgency=16

export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
./main ../../input/gsm_106857/gsm_106857.mtx.mesh.matlab.seq.tiling.1024  ../../input/gsm_106857/gsm_106857.mtx.xyz 
./main ../../input/gsm_106857/gsm_106857.mtx.mesh.matlab.seq.tiling.2048  ../../input/gsm_106857/gsm_106857.mtx.xyz 
./main ../../input/gsm_106857/gsm_106857.mtx.mesh.matlab.seq.tiling.4096  ../../input/gsm_106857/gsm_106857.mtx.xyz 
./main ../../input/gsm_106857/gsm_106857.mtx.mesh.matlab.seq.tiling.8192  ../../input/gsm_106857/gsm_106857.mtx.xyz 
