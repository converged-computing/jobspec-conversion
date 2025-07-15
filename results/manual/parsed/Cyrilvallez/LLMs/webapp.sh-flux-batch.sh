#!/bin/bash
#FLUX: --job-name=webapp
#FLUX: -c=4
#FLUX: --queue=nodes
#FLUX: -t=864000
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate llm
../frp_server/frp_0.54.0_linux_amd64/frpc -c ../frp_server/frpc/frpc_play.toml &
python3 -u webapp.py "$@"
conda deactivate
