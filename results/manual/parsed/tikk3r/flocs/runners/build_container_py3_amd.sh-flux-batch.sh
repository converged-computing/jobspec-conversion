#!/bin/bash
#FLUX: --job-name=build_container
#FLUX: -c=6
#FLUX: -t=10800
#FLUX: --urgency=16

singularity build --fakeroot --force lofar_sksp_v4.0.2_znver2_znver2_noavx512_aocl_cuda_ddf.sif Singularity.amd_aocl
