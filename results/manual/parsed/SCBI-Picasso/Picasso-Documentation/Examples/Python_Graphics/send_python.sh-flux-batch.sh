#!/bin/bash
#FLUX: --job-name=stanky-bicycle-5473
#FLUX: -t=600
#FLUX: --urgency=16

module load python/3.9.13
time python python_script.py
