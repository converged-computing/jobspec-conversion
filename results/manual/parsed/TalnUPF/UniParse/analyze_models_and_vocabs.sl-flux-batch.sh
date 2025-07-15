#!/bin/bash
#FLUX: --job-name="analyze"
#FLUX: --priority=16

module load Tensorflow-gpu/1.12.0-foss-2017a-Python-3.6.4
module load scikit-learn/0.19.1-foss-2017a-Python-3.6.4
module load dynet/2.1-foss-2017a-Python-3.6.4-GPU-CUDA-9.0.176
python analyze_models_and_vocabs.py
