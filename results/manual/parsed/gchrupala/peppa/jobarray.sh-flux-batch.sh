#!/bin/bash
#FLUX: --job-name=eccentric-underoos-7309
#FLUX: --priority=16

conda activate home
cd /home/gchrupal/peppa
source ./bin/activate
python run.py --config_file $1
