#!/bin/bash
#FLUX: --job-name=RespTest
#FLUX: --queue=shared
#FLUX: -t=9000
#FLUX: --urgency=16

date
module purge
conda activate obspy
python test-ReadandRemoval_Obspy_TA.py
/n/home03/kokubo/packages/julia-1.2.0/bin/julia test-ReadandRemoval_TA.jl
echo all process has been done.
