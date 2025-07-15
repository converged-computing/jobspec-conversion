#!/bin/bash
#FLUX: --job-name=Q1
#FLUX: -N=10
#FLUX: -n=40
#FLUX: --queue=broadwl
#FLUX: -t=600
#FLUX: --priority=16

module load python 
module load cuda
python finished.py
