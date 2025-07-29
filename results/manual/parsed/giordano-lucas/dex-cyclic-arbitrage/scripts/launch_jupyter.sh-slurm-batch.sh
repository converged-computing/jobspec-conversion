#!/bin/bash
#FLUX: --job-name=ipython-trial2
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

module load gcc mvapich2 py-tensorflow
source opt/venv-gcc/bin/activate
ipnport=$(shuf -i8000-9999 -n1)
jupyter-notebook --no-browser --port=${ipnport} --ip=$(hostname -i)
