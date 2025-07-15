#!/bin/bash
#FLUX: --job-name=blank-buttface-6695
#FLUX: --priority=16

export PATH='<your path>:$PATH'

export PATH=<your path>:$PATH
mpirun -n 97 python main-parallel-cc.py
