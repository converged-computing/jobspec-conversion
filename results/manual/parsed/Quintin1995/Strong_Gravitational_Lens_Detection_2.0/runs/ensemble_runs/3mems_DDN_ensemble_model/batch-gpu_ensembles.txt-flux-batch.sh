#!/bin/bash
#FLUX: --job-name=ensembles
#FLUX: --queue=gpu
#FLUX: -t=54000
#FLUX: --urgency=16

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 create_input_dep_ensemble.py --run=runs/ensemble_runs/run${SLURM_ARRAY_TASK_ID}.yaml
