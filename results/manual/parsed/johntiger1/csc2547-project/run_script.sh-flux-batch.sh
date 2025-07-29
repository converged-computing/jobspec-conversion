#!/bin/bash
#FLUX --job-name=blue-kerfuffle-6213
#FLUX -c=2
#FLUX --queue=gpu
#FLUX --urgency=16

module load pytorch1.0-cuda9.0-python3.6
python main.py --cuda
