#!/bin/bash
#FLUX: --job-name=quirky-squidward-4448
#FLUX: --urgency=16

cd $(ws_find lth_ws)
source lth_env/bin/activate
pip list
python3 -c "import torch; print(torch.__version__)"
python3 -c "import torch; print(torch.cuda.is_available())"
cd MetaSSL/metassl/
echo "Pretrain Simsiam with CIFAR10 and Knn Run 2"
python3 -m metassl.train_simsiam --expt_name run2_simsiam_cifar10 --epochs 500 --expt_mode CIFAR10 --workers 8 --seed 125 --run_knn_val
deactivate
