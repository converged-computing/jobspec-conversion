#!/bin/bash
#FLUX: --job-name=DataPreProcessing
#FLUX: --queue=C032M0512G
#FLUX: --urgency=50

python -u get_pre_data_MASS.py
