#!/bin/bash
#FLUX: --job-name=moolicious-lentil-4812
#FLUX: -n=28
#FLUX: --priority=16

export XDG_RUNTIME_DIR=''

module load python/3.6.3
module load jupyter/1.0.0
module load numpy pandas h5py matplotlib dask scikit-image scikit-learn
export XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="zeus"
port=8888
echo -e "
Command to create ssh tunnel:
ssh -N -f -L ${port}:${node}:${port} ${user}@${cluster}.pawsey.org.au
Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"
jupyter-notebook --no-browser --port=${port} --ip=${node}
