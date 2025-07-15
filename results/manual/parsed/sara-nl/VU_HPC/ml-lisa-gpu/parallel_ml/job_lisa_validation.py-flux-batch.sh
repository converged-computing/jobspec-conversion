#!/bin/bash
#FLUX: --job-name=crusty-underoos-8678
#FLUX: -N=2
#FLUX: --queue=gpu
#FLUX: --urgency=16

time horovodrun -np 2 -H localhost:2  python mnist_hvd_2.py
