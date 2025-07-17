#!/bin/bash
#FLUX: --job-name=3dseg-torch_predict
#FLUX: -c=6
#FLUX: --queue=alpha
#FLUX: -t=7200
#FLUX: --urgency=16

<<<<<<< HEAD
module load release/23.04 GCC/12.2.0 Python/3.10.8 OpenMPI/4.1.4 CUDA/11.8.0
nvidia-smi
source .venv_3dseg/bin/activate
echo $1
python ./scripts/predict.py --config $1
=======
module load release/23.04 GCC/12.2.0 Python/3.10.8 OpenMPI/4.1.4 CUDA/11.8.0
nvidia-smi
source .venv_3dseg/bin/activate
echo $1
python ./scripts/predict.py --config $1
>>>>>>> bf47220be6f13ee0507fdac5f20cdda293e61b5c
exit 0
