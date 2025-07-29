#!/bin/bash
#FLUX: --job-name=4D_array_comparison
#FLUX: -c=10
#FLUX: --queue=trc
#FLUX: -t=345600
#FLUX: --urgency=16

ml python/3.9.0
ml py-h5py/3.7.0_py39
source .env_snakemake/bin/activate
python3 sherlock_test.py
