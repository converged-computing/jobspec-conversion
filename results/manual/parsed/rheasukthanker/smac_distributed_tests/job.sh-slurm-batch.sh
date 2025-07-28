#!/bin/bash
#FLUX: --job-name=fairnas
#FLUX: -c=4
#FLUX: --queue=mldlc_gpu-rtx2080
#FLUX: -t=518400
#FLUX: --urgency=16

python src/search/search_dask.py
