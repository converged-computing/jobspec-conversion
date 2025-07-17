#!/bin/bash
#FLUX: --job-name=build_container
#FLUX: -t=28800
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity build --sandbox /red/nvidia-ai/SkylarStolte/monaicore08/ docker://projectmonai/monai:0.8.1
singularity exec --nv /red/nvidia-ai/SkylarStolte/monaicore08 nsys status -e
