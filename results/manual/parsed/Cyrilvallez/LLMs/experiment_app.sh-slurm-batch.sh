#!/bin/bash
#FLUX: --job-name=experiment_app
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=864000
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate llm
../frp_server/frp_0.54.0_linux_amd64/frpc -c ../frp_server/frpc/frpc_experiment.toml &
python3 -u experiment_webapp.py
conda deactivate
