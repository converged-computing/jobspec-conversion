#!/bin/bash
#FLUX: --job-name=nerdy-taco-2084
#FLUX: -t=240
#FLUX: --urgency=16

time julia main_rk4.jl
