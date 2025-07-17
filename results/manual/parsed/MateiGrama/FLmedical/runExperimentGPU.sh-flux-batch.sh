#!/bin/bash
#FLUX: --job-name=purple-banana-3881
#FLUX: --urgency=16

source /vol/bitbucket/mgg17/diss/venv/bin/activate
source /vol/cuda/10.0.130/setup.sh
TERM=vt100
/usr/bin/nvidia-smi
add-apt-repository ppa:openjdk-r/ppa
apt-get update -q
apt install -y openjdk-11-jdk
uptime
nohup python -u main.py > out/experimentAFAxis.log 2>&1
