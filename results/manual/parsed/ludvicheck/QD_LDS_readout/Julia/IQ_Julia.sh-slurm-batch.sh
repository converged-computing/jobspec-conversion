#!/bin/bash
#FLUX: --job-name=iq_julia_job
#FLUX: --queue=amd
#FLUX: -t=82800
#FLUX: --urgency=16

module load SciPy-bundle
module load mosek
module load Julia
cd /mnt/personal/cignalud/QD_LDS_readout/Julia
julia IQ_Julia_script.jl
