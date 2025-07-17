#!/bin/bash
#FLUX: --job-name=cowy-avocado-0274
#FLUX: -t=3600
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity exec -B /blue/vendor-nvidia/hju/monailabel_samples:/workspace /apps/nvidia/containers/monai/monailabel.0.6.0/0.6.0 monailabel apps --download --name pathology --output /workspace/apps
