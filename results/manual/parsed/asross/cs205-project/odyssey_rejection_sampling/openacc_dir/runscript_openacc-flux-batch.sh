#!/bin/bash
#FLUX: --job-name=eccentric-leopard-4509
#FLUX: --urgency=16

pgc++ -acc -ta=nvidia -Minfo=accel -o openacc openacc.cpp
./openacc > "out-openacc.txt"
