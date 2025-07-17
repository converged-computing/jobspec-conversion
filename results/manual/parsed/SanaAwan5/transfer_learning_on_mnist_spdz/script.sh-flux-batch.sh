#!/bin/bash
#FLUX: --job-name=muffled-lemur-0261
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --queue=intel
#FLUX: --urgency=16

module load Python/3.6.9
source /scratch/sanaawan/PySyft/venv/bin/activate
which python
python examples/tutorials/transfer_learning1.py
