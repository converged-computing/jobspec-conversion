#!/bin/bash
#FLUX: --job-name=conspicuous-platanos-8470
#FLUX: --priority=16

module load Python/3.6.9
source /scratch/sanaawan/PySyft/venv/bin/activate
which python
cd examples/tutorials/
python transfer_learning1.py
