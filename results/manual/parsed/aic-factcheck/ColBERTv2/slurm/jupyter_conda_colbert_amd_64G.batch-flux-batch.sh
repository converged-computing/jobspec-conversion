#!/bin/bash
#FLUX: --job-name=nerdy-carrot-0905
#FLUX: -c=4
#FLUX: --queue=amd
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='.:/home/drchajan/devel/python/FC/drchajan/src:/home/drchajan/devel/python/FC/fever-baselines/src:$PYTHONPATH'

if [[ -z "${PROJECT_DIR}" ]]; then
    export PROJECT_DIR="$(dirname "$(pwd)")"
fi
cd ${PROJECT_DIR}
ml Anaconda3
eval "$(conda shell.bash hook)"
conda activate colbert_cpu
XDG_RUNTIME_DIR=""
port=$(shuf -i8000-9999 -n1)
node=$(hostname -s)
user=$(whoami)
echo -e "
MacOS or linux terminal command to create your ssh tunnel for Jupyter and for Dash app on 8050:
ssh -N -L ${port}:${node}:${port} ${user}@login.rci.cvut.cz
with additional port:
ssh -N -L ${port}:${node}:${port} -L 8050:${node}:8050 ${user}@login.rci.cvut.cz
Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"
export PYTHONPATH=.:/home/drchajan/devel/python/FC/drchajan/src:/home/drchajan/devel/python/FC/fever-baselines/src:$PYTHONPATH
jupyter-lab --no-browser --port=${port} --ip=${node} --NotebookApp.iopub_data_rate_limit=1.0e10 --ServerApp.iopub_msg_rate_limit=1.0e10
