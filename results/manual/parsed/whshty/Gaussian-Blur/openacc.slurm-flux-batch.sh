#!/bin/bash
#FLUX: --job-name=stanky-house-7975
#FLUX: -c=12
#FLUX: --queue=gpufermi
#FLUX: --urgency=16

cp 500.bmp *.c $PFSDIR/.
cd $PFSDIR
module load pgi
pgcc -ta=nvidia:cc20 -acc openacc.c -o openacc -lm
echo size 500 
./openacc 10 500
