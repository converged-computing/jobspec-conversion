#!/bin/bash
#FLUX: --job-name=associator
#FLUX: --queue=preempt
#FLUX: --urgency=16

module purge
module load tensorflow2
cd /home/jsearcy/cascadia_data_mining
python train_associator_v2.py >> associator_log
