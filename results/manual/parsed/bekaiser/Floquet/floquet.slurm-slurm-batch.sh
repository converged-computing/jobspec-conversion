#!/bin/bash
#FLUX: --job-name=floq
#FLUX: --queue=sched_mit_raffaele
#FLUX: -t=172800
#FLUX: --urgency=16

source ~/dedalus_paths
module list
python3 floquet.py
