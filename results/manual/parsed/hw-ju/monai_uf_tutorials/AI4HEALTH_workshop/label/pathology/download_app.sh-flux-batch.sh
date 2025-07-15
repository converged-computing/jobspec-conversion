#!/bin/bash
#FLUX: --job-name=peachy-kerfuffle-0907
#FLUX: -t=3600
#FLUX: --priority=16

date;hostname;pwd
module load singularity
singularity exec -B /blue/vendor-nvidia/hju/monailabel_samples:/workspace /apps/nvidia/containers/monai/monailabel.0.6.0/0.6.0 monailabel apps --download --name pathology --output /workspace/apps
