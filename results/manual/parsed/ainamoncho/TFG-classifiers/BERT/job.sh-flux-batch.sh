#!/bin/bash
#FLUX: --job-name=my_job
#FLUX: -c=8
#FLUX: -t=5400
#FLUX: --urgency=16

ml scikit-learn/0.23.2-foss-2020b
ml NLTK/3.7-foss-2020b
ml PyTorch-Geometric/2.0.2-foss-2020b-PyTorch-1.10.0-CUDA-11.4.3
ml Transformers/4.24.0-foss-2020b
ml datasets/2.10.1-foss-2020b-Python-3.8.6
python transformer.py
