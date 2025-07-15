#!/bin/bash
#FLUX: --job-name=stinky-nalgas-3610
#FLUX: -n=2
#FLUX: -t=600
#FLUX: --priority=16

julia --project=test try_gpu_accel.jl > gpu_accel_print.out
