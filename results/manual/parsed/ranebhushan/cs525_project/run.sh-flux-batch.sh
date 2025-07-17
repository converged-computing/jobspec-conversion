#!/bin/bash
#FLUX: --job-name=DDDQN
#FLUX: -n=4
#FLUX: --queue=long
#FLUX: -t=604799
#FLUX: --urgency=16

echo "Running python code on $(hostname) with algorithm $1"
python3 src/main.py --agent_config_path=configs/$1.yaml --env_config_path=configs/highway-env_config.json
