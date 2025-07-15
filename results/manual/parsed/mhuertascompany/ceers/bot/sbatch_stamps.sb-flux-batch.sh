#!/bin/bash
#FLUX: --job-name=zoobot_COSMOS-Web
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

module load intelpython/3-2024.1.0
module load gcc/13.2.0
cd /n03data/huertas/python/ceers/make_stamps
python make_stamps.py
