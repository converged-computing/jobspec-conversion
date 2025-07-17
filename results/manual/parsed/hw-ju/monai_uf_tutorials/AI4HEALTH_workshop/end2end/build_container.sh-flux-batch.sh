#!/bin/bash
#FLUX: --job-name=fat-cinnamonbun-3954
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity build --sandbox /blue/vendor-nvidia/hju/workshop_rapids23.02 docker://nvcr.io/nvidia/rapidsai/rapidsai-core:23.02-cuda11.8-runtime-ubuntu22.04-py3.8
singularity exec --writable /blue/vendor-nvidia/hju/workshop_rapids23.02 pip install monai==1.1.0
