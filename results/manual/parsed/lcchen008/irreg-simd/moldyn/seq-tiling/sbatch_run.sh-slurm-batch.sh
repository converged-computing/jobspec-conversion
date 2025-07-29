#!/bin/bash
#FLUX: --job-name=seq-tiling
#FLUX: --queue=normal-mic
#FLUX: -t=1500
#FLUX: --urgency=16

export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
./main ../../input/32-3.0r/32-3.0r.mesh.matlab.seq.tiling.128   ../../input/32-3.0r/32-3.0r.xyz
./main ../../input/32-3.0r/32-3.0r.mesh.matlab.seq.tiling.256   ../../input/32-3.0r/32-3.0r.xyz
./main ../../input/32-3.0r/32-3.0r.mesh.matlab.seq.tiling.512   ../../input/32-3.0r/32-3.0r.xyz
./main ../../input/32-3.0r/32-3.0r.mesh.matlab.seq.tiling.1024  ../../input/32-3.0r/32-3.0r.xyz
./main ../../input/32-3.0r/32-3.0r.mesh.matlab.seq.tiling.2048  ../../input/32-3.0r/32-3.0r.xyz
./main ../../input/32-3.0r/32-3.0r.mesh.matlab.seq.tiling.4096  ../../input/32-3.0r/32-3.0r.xyz
./main ../../input/32-3.0r/32-3.0r.mesh.matlab.seq.tiling.8192  ../../input/32-3.0r/32-3.0r.xyz
./main ../../input/32-3.0r/32-3.0r.mesh.matlab.seq.tiling.16384 ../../input/32-3.0r/32-3.0r.xyz
