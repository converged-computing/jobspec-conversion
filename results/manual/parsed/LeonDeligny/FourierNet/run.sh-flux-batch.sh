#!/bin/bash
#FLUX: --job-name=out
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

python __main__.py
