#!/bin/bash
#FLUX: --job-name=lovable-caramel-3751
#FLUX: -t=600
#FLUX: --priority=16

module load python/3.9.13
time python python_script.py
