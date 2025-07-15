#!/bin/bash
#FLUX: --job-name=ensemble_test
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --priority=16

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 create_input_dep_ensemble.py --ensemble_name multi_test2 --network simple_net n_chunks 200
