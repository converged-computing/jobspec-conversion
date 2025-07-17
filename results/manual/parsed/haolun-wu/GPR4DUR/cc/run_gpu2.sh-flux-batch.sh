#!/bin/bash
#FLUX: --job-name=purple-cattywampus-4471
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

source /home/haolun/projects/def-cpsmcgil/haolun/GPR4DUR/venv_gpr4dur/bin/activate
module load cuda
nvidia-smi
python3 /home/haolun/projects/def-cpsmcgil/haolun/GPR4DUR/synthetic/synthetic_GPR_browsing.py
deactivate
