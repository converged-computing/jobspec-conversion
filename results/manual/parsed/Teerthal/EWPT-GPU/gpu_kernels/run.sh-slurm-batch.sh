#!/bin/bash
#FLUX: --job-name=carnivorous-earthworm-6392
#FLUX: -t=240
#FLUX: --urgency=16

time julia main_rk4.jl
