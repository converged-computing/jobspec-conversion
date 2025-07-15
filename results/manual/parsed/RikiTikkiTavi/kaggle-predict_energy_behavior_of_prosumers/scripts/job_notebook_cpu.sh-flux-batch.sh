#!/bin/bash
#FLUX: --job-name="ebop-notebook"
#FLUX: -c=8
#FLUX: --queue=alpha
#FLUX: -t=28800
#FLUX: --priority=16

export XDG_RUNTIME_DIR=''

module load GCC/11.3.0 Python/3.10.4 CUDA/12.0.0
source /beegfs/ws/0/s4610340-energy_behavior/yahor/kaggle-predict_energy_behavior_of_prosumers/.venv/bin/activate
export XDG_RUNTIME_DIR=""
cd /beegfs/ws/0/s4610340-energy_behavior/yahor/kaggle-predict_energy_behavior_of_prosumers/notebooks && jupyter notebook --no-browser --port=8888 --NotebookApp.token=fb907dde42aafe7bd38b25a928cfe18225404f8b8ea30f20
