#!/bin/bash
#FLUX: --job-name=ornery-bits-8755
#FLUX: --urgency=16

module load Python/3.6.9
source /scratch/sanaawan/PySyft/venv/bin/activate
which python
python examples/tutorials/transfer_learning1.py
