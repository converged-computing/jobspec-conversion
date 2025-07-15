#!/bin/bash
#FLUX: --job-name=tart-pot-3150
#FLUX: --priority=16

module add cudnn/5.1-cuda-8.0
module load anaconda/py35/4.2.0
source activate tensorflow
pip install --user -r requirements3.txt
python make_datasets.py combine
source deactivate
