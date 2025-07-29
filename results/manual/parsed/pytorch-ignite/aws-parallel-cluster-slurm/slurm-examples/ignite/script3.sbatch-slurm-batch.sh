#!/bin/bash
#FLUX: --job-name=script3
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=cpu-compute-spot
#FLUX: -t=300
#FLUX: --urgency=16

set -e
cmd="pip install --upgrade git+https://github.com/pytorch/ignite.git && python check_idist.py --backend=gloo"
cname="/shared/enroot_data/pytorchignite+vision+latest.sqsh"
NVIDIA_VISIBLE_DEVICES="" srun -l --container-name=ignite-vision --container-image=$cname --no-container-remap-root --container-workdir=$PWD bash -c "$cmd"
