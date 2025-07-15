#!/bin/bash
#FLUX: --job-name=purple-plant-5993
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --priority=16

date;hostname;pwd
module load singularity
singularity build --sandbox /blue/vendor-nvidia/hju/workshop_monaicore1.0.1 docker://projectmonai/monai:1.0.1
singularity exec --writable /blue/vendor-nvidia/hju/workshop_monaicore1.0.1 pip install -r https://raw.githubusercontent.com/Project-MONAI/MONAI/dev/requirements-dev.txt
