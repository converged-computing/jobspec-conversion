#!/bin/bash
#FLUX: --job-name=gpu_example
#FLUX: --queue=gpu_test
#FLUX: -t=1800
#FLUX: --urgency=16

singularity run --nv tensorflow_latest-gpu.sif python -c 'from tensorflow.python.client import device_lib; print(device_lib.list_local_devices())'
