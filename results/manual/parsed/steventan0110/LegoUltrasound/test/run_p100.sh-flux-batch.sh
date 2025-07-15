#!/bin/bash
#FLUX: --job-name=matlab_p100
#FLUX: -c=6
#FLUX: -t=43200
#FLUX: --priority=16

ml cuda/8.0
ml gcc/5.5.0
ml # confirm modules used
for foldername in ~/work/yixuan/data/{1485..1500} ; do
    for filename in $foldername/*.h5; do
        ./k-Wave/binaries/kspaceFirstOrder3D-CUDA -i "$filename" -o "$filename" -p
    done
done
