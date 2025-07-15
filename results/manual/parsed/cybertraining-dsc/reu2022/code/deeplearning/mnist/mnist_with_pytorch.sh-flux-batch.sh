#!/bin/bash
#FLUX: --job-name=mnist_with_pytorch.sh
#FLUX: --queue=gpu
#FLUX: -t=180
#FLUX: --priority=16

echo "# cloudmesh status=running progress=1 pid=$$"
nvidia-smi --list-gpus
source activate ENV3
python mnist_with_pytorch.py
echo " cloudmesh status=done progress=100 pid=$$"#
