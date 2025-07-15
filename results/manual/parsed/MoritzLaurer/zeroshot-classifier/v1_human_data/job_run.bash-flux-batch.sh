#!/bin/bash
#FLUX: --job-name=zs
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load 2021
module load Python/3.9.5-GCCcore-10.3.0
cd ./zeroshot
pip install --upgrade pip
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
pip install -r requirements.txt
echo "Checking PyTorch and CUDA compatibility"
python -c "import torch; print('PyTorch version:', torch.__version__); print('CUDA is available:', torch.cuda.is_available()); print('CUDA version:', torch.version.cuda); print('CUDNN version:', torch.backends.cudnn.version())"
dataset_name_heldout=$1
do_train=$2
upload_to_hub=$3
echo "Running experiment with parameter: dataset_name_heldout = $dataset_name_heldout,  do_train = $do_train,  upload_to_hub = $upload_to_hub"
python 4_train_eval.py --dataset_name_heldout "$dataset_name_heldout" --do_train "$do_train" --upload_to_hub "$upload_to_hub" &> "./logs/logs_$dataset_name_heldout-$(date +"%y%m%d%H%M").txt"
