#!/bin/bash
#FLUX: --job-name=expressive-poodle-6159
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load Python/3.6.9
source /scratch/sanaawan/PySyft/venv/bin/activate
which python
cd examples/tutorials/
python transfer_learning1.py
