#!/bin/bash
#FLUX: --job-name=gassy-peanut-butter-2337
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python task_a_FAISS.py
