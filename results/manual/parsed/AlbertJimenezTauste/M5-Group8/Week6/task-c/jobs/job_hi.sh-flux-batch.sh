#!/bin/bash
#FLUX: --job-name=frigid-house-5586
#FLUX: --priority=16

python ~/tensorflow/models/research/deeplab/model_test.py -p mhigh
