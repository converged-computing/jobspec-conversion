#!/bin/bash
#FLUX: --job-name=hello-leopard-1402
#FLUX: -t=28800
#FLUX: --priority=16

date;hostname;pwd
module load singularity
singularity exec -B /blue/vendor-nvidia/hju/monailabel_samples:/workspace /apps/nvidia/containers/monai/monailabel/ monailabel apps --download --name deepedit --output /workspace/apps
singularity exec -B /blue/vendor-nvidia/hju/monailabel_samples:/workspace /apps/nvidia/containers/monai/monailabel/ monailabel datasets --download --name Task03_Liver --output /workspace/datasets
