#!/bin/bash
#FLUX: --job-name=GPUtest
#FLUX: --queue=owners
#FLUX: -t=7200
#FLUX: --urgency=16

ml gsl
ml python/3.9
ml py-scipy/1.6.3_py39
ml viz
ml py-matplotlib/3.4.2_py39
ml cmake/3.13.1
ml py-numpy/1.20.3_py39
ml cudnn/8.1.1.33
ml py-pytorch/1.8.1_py39
ml cuda/11.1.1
N="9"
nvidia-smi
srun python3 run_ensemble_eval.py heads_only_choice --data_list spectra_68720/test_aug6/train/ --ensemble heads_only_new --datatype sim --batch_size 512
