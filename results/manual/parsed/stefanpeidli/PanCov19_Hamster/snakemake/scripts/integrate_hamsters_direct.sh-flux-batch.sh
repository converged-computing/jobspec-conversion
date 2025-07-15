#!/bin/bash
#FLUX: --job-name=gpu_test
#FLUX: --priority=16

python integrate_hamsters_direct.py
echo "Done"
