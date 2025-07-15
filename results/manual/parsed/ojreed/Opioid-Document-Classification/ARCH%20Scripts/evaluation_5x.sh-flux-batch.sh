#!/bin/bash
#FLUX: --job-name=oreed2EvalResults
#FLUX: -c=4
#FLUX: --queue=a100
#FLUX: -t=14400
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0'

ml purge
ml gcc/9.3.0
ml cuda/11.1.0
ml anaconda/2020.07
ml pyTorch/1.8.1-cuda-11.1.1
GPUS_PER_NODE=1
export CUDA_VISIBLE_DEVICES=0
cd /scratch4/angieliu/Opi_Files/
module load python/3.8.6
python3 -m venv myenv
source myenv/bin/activate
pip install pandas torch transformers
pip install torchvision
pip install scikit-learn
python Mixed_Labeled_BioBERT.py 25 1e-04 Mixed_1500 > Mixed_1500.log
python s2_1500_BioBERT_R.py 25 1e-04 s2_1500_R3 > s2_1500_R3.log
python s2_1500_BioBERT_R.py 25 1e-04 s2_1500_R4 > s2_1500_R4.log
python s2_1500_BioBERT_R.py 25 1e-04 s2_1500_R5 > s2_1500_R5.log
deactivate
