#!/bin/bash
#FLUX: --job-name=moolicious-lizard-3098
#FLUX: --priority=16

export MIC_LD_LIBRARY_PATH='$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/'

export MIC_LD_LIBRARY_PATH=$MIC_LD_LIBRARY_PATH:/opt/apps/intel/13/composer_xe_2013.2.146/compiler/lib/mic/
./main ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.tiling.128   ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.offset.128   ../../input/45-3.0r/45-3.0r.xyz.reordered 
./main ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.tiling.256   ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.offset.256   ../../input/45-3.0r/45-3.0r.xyz.reordered
./main ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.tiling.512   ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.offset.512   ../../input/45-3.0r/45-3.0r.xyz.reordered
./main ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.tiling.1024  ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.offset.1024  ../../input/45-3.0r/45-3.0r.xyz.reordered
./main ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.tiling.2048  ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.offset.2048  ../../input/45-3.0r/45-3.0r.xyz.reordered
./main ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.tiling.4096  ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.offset.4096  ../../input/45-3.0r/45-3.0r.xyz.reordered
./main ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.tiling.8192  ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.offset.8192  ../../input/45-3.0r/45-3.0r.xyz.reordered
./main ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.tiling.16384 ../../input/45-3.0r/45-3.0r.mesh.matlab.reordered.offset.16384 ../../input/45-3.0r/45-3.0r.xyz.reordered
