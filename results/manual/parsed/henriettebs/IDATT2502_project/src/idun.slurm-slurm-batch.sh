#!/bin/bash
#FLUX: --job-name=Stock prediction training
#FLUX: -c=28
#FLUX: --queue=GPUQ
#FLUX: -t=14400
#FLUX: --urgency=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
module load Python/3.10.4-GCCcore-11.3.0
pip install numpy
pip install torch
pip install yahoo_fin
pip install tensorflow
pip install scikit_learn
pip install keras
pip install matplotlib
pip install pandas
pip install statsmodels
pip install yfinance
python3 src/main.py
