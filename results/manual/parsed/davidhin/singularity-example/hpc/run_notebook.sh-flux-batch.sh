#!/bin/bash
#FLUX: --job-name=gpunb
#FLUX: --queue=batch
#FLUX: -t=45000
#FLUX: --urgency=16

module load Singularity
module load CUDA/10.2.89
port=$(shuf -i8000-9999 -n1)
node=$(hostname -s)
user=$(whoami)
cluster=$(hostname -f | awk -F"." '{print $2}')
echo "Paste this command in your terminal."
echo "ssh -N -L ${port}:${node}:${port} -L 6006:${node}:6006 ${user}@${cluster}phoenix-login1.adelaide.edu.au"
singularity exec --nv main.simg jupyter notebook --port=${port} --ip=${node}
