#!/bin/bash
#FLUX --job-name=angry-ricecake-2914
#FLUX -t=240
#FLUX --urgency=16

time julia main_rk4.jl
