#!/bin/bash
#FLUX: --job-name=stanky-punk-6833
#FLUX: -n=2
#FLUX: -t=600
#FLUX: --urgency=16

julia --project=test try_gpu_accel.jl > gpu_accel_print.out
