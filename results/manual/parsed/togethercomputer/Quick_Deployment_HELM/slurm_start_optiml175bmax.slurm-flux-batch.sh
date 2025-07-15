#!/bin/bash
#FLUX: --job-name=together-alpa-OPT-175B
#FLUX: -c=8
#FLUX: --queue=sphinx
#FLUX: -t=3600
#FLUX: --priority=16

cd /nlp/scr2/nlp/fmStore/fm/dev/Quick_Deployment_HELM
nvidia-smi
docker run --rm --gpus '"device=0,1,2,3,4,5,6,7"' --ipc=host -v /nlp/scr2/nlp/fmStore/fm:/home/fm binhang/alpa /home/fm/dev/Quick_Deployment_HELM/start_local_optiml175bmax.sh
