#!/bin/bash
#FLUX: --job-name=conspicuous-leader-1660
#FLUX: --queue=physical
#FLUX: -t=43200
#FLUX: --priority=16

module load Python/3.6.4-intel-2017.u2
time mpiexec -n 1 python3 app.py bigTwitter.json melbGrid.json
