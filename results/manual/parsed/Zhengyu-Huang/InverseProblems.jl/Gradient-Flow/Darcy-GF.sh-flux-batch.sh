#!/bin/bash
#FLUX: --job-name=Darcy-GF
#FLUX: -t=604800
#FLUX: --urgency=16

julia  Darcy-GF.jl 
