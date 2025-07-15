#!/bin/bash
#FLUX: --job-name=crunchy-dog-1265
#FLUX: -N=2
#FLUX: --queue=gpu
#FLUX: --priority=16

time horovodrun -np 2 -H localhost:2  python mnist_hvd_2.py
