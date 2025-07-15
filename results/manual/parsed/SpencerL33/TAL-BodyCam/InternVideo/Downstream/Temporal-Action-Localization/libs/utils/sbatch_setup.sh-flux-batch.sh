#!/bin/bash
#FLUX: --job-name=BWC
#FLUX: -t=900
#FLUX: --urgency=16

:: #SBATCH --mem-per-cpu=16G
module load  StdEnv/2020  cuda cudnn
module load gcc opencv
nvidia-smi
source  ../../../../../ENV/bin/activate
echo "Testing..."
python setup.py install
