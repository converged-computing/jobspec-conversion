#!/bin/bash
#FLUX: --job-name=AlexNetVanilla
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=183600
#FLUX: --priority=16

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
source venv/bin/activate
pip freeze
python run_flow.py
