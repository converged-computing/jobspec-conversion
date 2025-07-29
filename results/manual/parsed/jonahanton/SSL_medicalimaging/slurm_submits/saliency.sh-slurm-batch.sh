#!/bin/bash
#SBATCH --output=/vol/bitbucket/g21mscprj03/SSL/out/saliency/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

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
