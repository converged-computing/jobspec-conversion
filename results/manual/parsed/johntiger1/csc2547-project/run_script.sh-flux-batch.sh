#!/bin/bash
#FLUX: --job-name=arid-milkshake-7502
#FLUX: --urgency=16

module load pytorch1.0-cuda9.0-python3.6
python main.py --cuda
