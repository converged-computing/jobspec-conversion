#!/bin/bash
#FLUX: --job-name=lstm
#FLUX: --queue=titanx-long
#FLUX: -t=176400
#FLUX: --urgency=16

source /home/rgangaraju/.bashrc
source activate tf
hostname
python -u /home/rgangaraju/lstm/generic_lstm.py
sleep 1
exit
