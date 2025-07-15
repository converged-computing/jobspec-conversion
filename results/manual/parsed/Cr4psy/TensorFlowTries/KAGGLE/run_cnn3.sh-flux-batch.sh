#!/bin/bash
#FLUX: --job-name=adorable-kerfuffle-6082
#FLUX: -t=86400
#FLUX: --urgency=16

module add cudnn/5.1-cuda-8.0
module load anaconda/py35/4.2.0
source activate tensorflow1.1
jupyter nbconvert --to notebook --ExecutePreprocessor.timeout=300 --execute CNNKaggle.ipynb
source deactivate
