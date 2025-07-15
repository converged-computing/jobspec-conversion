#!/bin/bash
#FLUX: --job-name=gpu_test
#FLUX: --urgency=16

python integrate_hamsters_direct.py
echo "Done"
