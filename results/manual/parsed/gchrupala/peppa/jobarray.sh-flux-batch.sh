#!/bin/bash
#FLUX --job-name=placid-hope-6520
#FLUX --queue=GPUExtended
#FLUX -t=2880
#FLUX --urgency=16

conda activate home
cd /home/gchrupal/peppa
source ./bin/activate
python run.py --config_file $1
