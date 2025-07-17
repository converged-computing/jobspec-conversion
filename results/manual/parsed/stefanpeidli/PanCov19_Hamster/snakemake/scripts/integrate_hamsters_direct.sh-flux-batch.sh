#!/bin/bash
#FLUX: --job-name=gpu_test
#FLUX: -n=2
#FLUX: --queue=gpu-el8
#FLUX: -t=82800
#FLUX: --urgency=16

python integrate_hamsters_direct.py
echo "Done"
