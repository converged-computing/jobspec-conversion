#!/bin/bash
#FLUX: --job-name=scruptious-lemur-0730
#FLUX: --urgency=16

conda activate home
cd /home/gchrupal/peppa
source ./bin/activate
python run.py --config_file $1
