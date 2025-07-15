#!/bin/bash
#FLUX: --job-name=placid-carrot-9644
#FLUX: --urgency=16

module load dask
python taxi_cab.py  
