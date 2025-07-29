#!/bin/bash
#FLUX: --job-name=moolicious-frito-8597
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python task_a_FAISS.py
