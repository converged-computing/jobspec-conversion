#!/bin/bash
#SBATCH --output=../logs/jupyter.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=128G
#SBATCH --time=1-00:00:00
#SBATCH --partition=amd
#SBATCH --constraint=ntasks-per-node=1

export PYTHONPATH='/home/drchajan/devel/python/FC/drchajan/src:/home/drchajan/devel/python/FC/fever-baselines/src:$PYTHONPATH'

if [[ -z "${PROJECT_DIR}" ]]; then
    export PROJECT_DIR="$(dirname "$(pwd)")"
fi
if [ -f "${PROJECT_DIR}/init_environment_hflarge_amd.sh" ]; then
    source "${PROJECT_DIR}/init_environment_hflarge_amd.sh"
fi
cd ${PROJECT_DIR}
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
export PYTHONPATH=/home/drchajan/devel/python/FC/drchajan/src:/home/drchajan/devel/python/FC/fever-baselines/src:$PYTHONPATH
jupyter-lab --no-browser --port=${port} --ip=${node} --NotebookApp.iopub_data_rate_limit=1.0e10 --ServerApp.iopub_msg_rate_limit=1.0e10
