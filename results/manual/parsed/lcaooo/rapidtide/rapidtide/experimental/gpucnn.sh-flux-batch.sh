#!/bin/bash
#FLUX --job-name=delicious-destiny-2019
#FLUX --queue=gpu
#FLUX -t=57600
#FLUX --urgency=16

module load cuda91
python main.py
