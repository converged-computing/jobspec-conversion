#!/bin/bash
#FLUX: --job-name=bloated-leg-9584
#FLUX: --queue=gpu_shared
#FLUX: -t=54000
#FLUX: --urgency=16

module load 2020
module load Python/3.8.2-GCCcore-9.3.0
module load CUDA/11.0.2-GCC-9.3.0
module load cuDNN/8.0.3.33-gcccuda-2020a
module load TensorFlow/2.3.1-fosscuda-2020a-Python-3.8.2
pip install --user zarr
pip install --user pandas
pip install --user scikit-learn
pip install --user tensorflow
pip install tensorflow-addons
python $HOME/check-gpu.py
if [ $? -ne 0 ]; then
    exit 1
fi
cp -r $HOME/data_processed_DL_reduced "$TMPDIR"
python $HOME/DL_train_01.py "$TMPDIR"/data_processed_DL_reduced $HOME/trained_models
