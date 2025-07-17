#!/bin/bash
#FLUX: --job-name=mustard
#FLUX: -n=4
#FLUX: --queue=i64m1tga800u
#FLUX: --urgency=16

module load cuda/11.8
bash run.sh
