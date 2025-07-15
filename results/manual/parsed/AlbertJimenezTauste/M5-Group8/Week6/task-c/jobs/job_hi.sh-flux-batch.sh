#!/bin/bash
#FLUX: --job-name=creamy-muffin-8715
#FLUX: --urgency=16

python ~/tensorflow/models/research/deeplab/model_test.py -p mhigh
