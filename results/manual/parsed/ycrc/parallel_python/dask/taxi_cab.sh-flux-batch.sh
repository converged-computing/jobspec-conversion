#!/bin/bash
#FLUX: --job-name=dask
#FLUX: --queue=admintest
#FLUX: --urgency=16

module load dask
python taxi_cab.py  
