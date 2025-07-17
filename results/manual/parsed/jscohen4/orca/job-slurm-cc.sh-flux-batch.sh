#!/bin/bash
#FLUX: --job-name=delicious-blackbean-7664
#FLUX: -n=97
#FLUX: --queue=high
#FLUX: -t=252000
#FLUX: --urgency=16

export PATH='<your path>:$PATH'

export PATH=<your path>:$PATH
mpirun -n 97 python main-parallel-cc.py
