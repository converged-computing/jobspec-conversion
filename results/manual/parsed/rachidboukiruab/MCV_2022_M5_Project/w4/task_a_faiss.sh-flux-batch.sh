#!/bin/bash
#FLUX --job-name=hello-fudge-4789
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python task_a_FAISS.py
