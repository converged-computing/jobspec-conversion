#!/bin/bash
#FLUX: --job-name=grated-leopard-4906
#FLUX: -t=28800
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity build --sandbox /blue/vendor-nvidia/hju/monaicore0.9.1 docker://projectmonai/monai:0.9.1
singularity exec --writable /blue/vendor-nvidia/hju/monaicore0.9.1 pip3 install -r https://raw.githubusercontent.com/Project-MONAI/MONAI/dev/requirements-dev.txt
