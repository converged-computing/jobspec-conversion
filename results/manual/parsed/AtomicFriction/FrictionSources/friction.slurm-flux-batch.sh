#!/bin/bash
#FLUX: --job-name=eccentric-butter-0163
#FLUX: -t=36000
#FLUX: --urgency=16

module load centos7.3/comp/python/3.8.12-openmpi-4.1.1-oneapi-2021.2
python3.8 main.py
exit
