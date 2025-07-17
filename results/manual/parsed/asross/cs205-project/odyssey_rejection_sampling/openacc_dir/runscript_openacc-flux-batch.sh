#!/bin/bash
#FLUX: --job-name=nerdy-chair-8715
#FLUX: --queue=holyseasgpu
#FLUX: -t=600
#FLUX: --urgency=16

pgc++ -acc -ta=nvidia -Minfo=accel -o openacc openacc.cpp
./openacc > "out-openacc.txt"
