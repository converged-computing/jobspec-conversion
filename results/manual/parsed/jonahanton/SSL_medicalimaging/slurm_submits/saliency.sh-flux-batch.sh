#!/bin/bash
#FLUX: --job-name=boopy-cinnamonbun-5582
#FLUX: --urgency=16

export PATH='/vol/bitbucket/g21mscprj03/sslvenv/bin/:$PATH'

.#!/bin/bash
export PATH=/vol/bitbucket/g21mscprj03/sslvenv/bin/:$PATH
source activate
source /vol/cuda/11.0.3-cudnn8.0.5.39/setup.sh
TERM=vt100  # TERM=xterm
/usr/bin/nvidia-smi
uptime
cd /vol/bitbucket/g21mscprj03/SSL
model=mimic-cxr_r18_lr_1e-4
python saliency.py -d imagenet -m $model
