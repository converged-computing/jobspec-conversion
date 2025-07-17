#!/bin/bash
#FLUX: --job-name=joyous-puppy-5302
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python3 torch_env_test.py
