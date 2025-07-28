#!/bin/bash
#FLUX: --job-name=hamnet
#FLUX: -c=4
#FLUX: --queue=GPU
#FLUX: -t=172800
#FLUX: --urgency=16

python model_test.py
