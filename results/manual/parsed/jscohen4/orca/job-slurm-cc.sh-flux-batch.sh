#!/bin/bash
#FLUX: --job-name=joyous-puppy-5110
#FLUX: --urgency=16

export PATH='<your path>:$PATH'

export PATH=<your path>:$PATH
mpirun -n 97 python main-parallel-cc.py
