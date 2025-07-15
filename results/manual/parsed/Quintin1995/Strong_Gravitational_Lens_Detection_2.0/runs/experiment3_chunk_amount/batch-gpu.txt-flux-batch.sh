#!/bin/bash
#FLUX: --job-name=expressive-sundae-6453
#FLUX: --queue=gpu
#FLUX: -t=27000
#FLUX: --priority=16

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 main.py --run=runs/experiment3_chunk_amount/run${SLURM_ARRAY_TASK_ID}.yaml
