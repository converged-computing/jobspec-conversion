#!/bin/bash
#FLUX: --job-name=Midterm Project
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
module load Python
pip install --user rdkit scikit-learn tensorflow numpy pandas matplotlib
srun python3 ./DSF/midterm.py
