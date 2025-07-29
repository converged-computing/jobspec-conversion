#!/bin/bash
#FLUX --job-name=chunky-fudge-0373
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python3 torch_env_test.py
