#!/bin/bash
#FLUX: --job-name=gpu_test
#FLUX: --queue=debug-gpu
#FLUX: -t=14400
#FLUX: --urgency=16

python Supersense_semeval.py
