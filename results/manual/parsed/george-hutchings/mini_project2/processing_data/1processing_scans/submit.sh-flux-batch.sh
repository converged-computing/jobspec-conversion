#!/bin/bash
#FLUX: --job-name=GHpscan
#FLUX: --queue=gpu-large
#FLUX: -t=7200
#FLUX: --urgency=16

module purge   # libraries used
module load TensorFlow/2.0.0-fosscuda-2019b-Python-3.7.4
module load Python/3.7.4-GCCcore-8.3.0
module load SimpleITK/1.2.4-foss-2019b-Python-3.7.4
module load scikit-learn/0.21.3-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
module load torchvision/0.7.0-fosscuda-2019b-Python-3.7.4-PyTorch-1.6.0
module load cleanlab/1.0-foss-2019b-Python-3.7.4
module load tqdm/4.41.1-GCCcore-8.3.0
module load NiBabel/3.2.0-foss-2019b-Python-3.7.4
module load OpenCV/4.2.0-foss-2019b-Python-3.7.4
module load timm/0.4.12-fosscuda-2019b-Python-3.7.4-PyTorch-1.6.0
module load h5py/2.10.0-fosscuda-2019b-Python-3.7.4
module load SciPy-bundle/2019.10-fosscuda-2019b-Python-3.7.4
module load Pillow/7.0.0-GCCcore-8.3.0-Python-3.7.4
module load pandas-plink/2.0.4-foss-2019b-Python-3.7.4
python T2gene_all_saves.py
