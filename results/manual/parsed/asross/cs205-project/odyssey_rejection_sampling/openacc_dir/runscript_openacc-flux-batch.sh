#!/bin/bash
#FLUX: --job-name=frigid-rabbit-7252
#FLUX: --priority=16

pgc++ -acc -ta=nvidia -Minfo=accel -o openacc openacc.cpp
./openacc > "out-openacc.txt"
