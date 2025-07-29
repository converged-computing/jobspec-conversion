#!/bin/bash
#FLUX: --job-name=Model Trainer
#FLUX: -c=32
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load  python/3.6.5-fwk5uaj
module load tensorflow-gpu/1.2.1/u16-cuda8.0-libcudnn5.1-py36
path=<ANONYMOUS>/<ANONYMOUS>/sysevr/Implementation/model
cd $path
tf-gpu python bgru.py
