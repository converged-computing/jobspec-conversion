#!/bin/bash
#FLUX: --job-name=MultiGPU
#FLUX: --queue=cuda
#FLUX: --urgency=16

export PATH='/Soft/cuda/11.2.1/bin:$PATH'

export PATH=/Soft/cuda/11.2.1/bin:$PATH
./kernel00.exe 10000 Y
./kernel00.exe 300000 N
./kernel00.exe 300000 N
./kernel00.exe 300000 N
