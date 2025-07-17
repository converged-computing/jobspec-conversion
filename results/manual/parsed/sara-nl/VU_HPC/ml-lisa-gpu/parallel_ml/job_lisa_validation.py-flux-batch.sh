#!/bin/bash
#FLUX: --job-name=hvd_test
#FLUX: -N=2
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

time horovodrun -np 2 -H localhost:2  python mnist_hvd_2.py
