#!/bin/bash
#FLUX: --job-name=ornery-kitty-2863
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ~/tensorflow/models/research/deeplab/model_test.py -p mhigh
