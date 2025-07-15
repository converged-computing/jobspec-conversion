#!/bin/bash
#FLUX: --job-name=dask-warp-demo
#FLUX: --queue=hns,normal
#FLUX: -t=1200
#FLUX: --urgency=16

singularity run docker://ghcr.io/phargogh/prototype-concurrency-in-pygeoprocessing:latest python example-sherlock.py
