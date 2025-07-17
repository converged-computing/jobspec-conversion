#!/bin/bash
#FLUX: --job-name=mod_agg
#FLUX: --exclusive
#FLUX: --queue=batch
#FLUX: --urgency=16

srun /umbc/xfs1/cybertrn/common/Softwares/anaconda3/bin/python monthly-aggregation-file-level-dask.py
