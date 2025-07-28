#!/bin/bash
#FLUX: --job-name=Train_Py
#FLUX: --queue=skylake
#FLUX: -t=3600
#FLUX: --urgency=16

module load python
module load numpy/1.14.1-python-2.7.14
module load tensorflowgpu/1.6.0-python-2.7.14
module load scikit-learn/0.19.1-python-2.7.14
module load keras/2.1.4-python-2.7.14
module load h5py/2.7.1-python-2.7.14-serial
python train.py
