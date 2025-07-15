#!/bin/bash
#FLUX: --job-name=phat-muffin-5160
#FLUX: --priority=16

module load dask
python taxi_cab.py  
