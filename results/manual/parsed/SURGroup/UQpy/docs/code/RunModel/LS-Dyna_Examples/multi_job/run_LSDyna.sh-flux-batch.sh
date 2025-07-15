#!/bin/bash
#FLUX: --job-name=UQpy_LSDyna_Test_Parallel
#FLUX: -N=3
#FLUX: --queue=parallel
#FLUX: -t=7200
#FLUX: --priority=16

module load ls-dyna/10.1.0
module load python
module load parallel
python dyna_model.py
