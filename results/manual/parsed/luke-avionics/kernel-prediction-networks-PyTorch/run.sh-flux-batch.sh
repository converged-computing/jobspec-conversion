#!/bin/bash
#FLUX: --job-name=gassy-sundae-1610
#FLUX: --exclusive
#FLUX: -t=720
#FLUX: --urgency=16

job=$1
/bin/bash
module load ROCm/4.1.0
module load GCC/10.2.0
module load OpenMPI/4.0.5
module load PyTorch/1.8.1
pip install configobj
pip install torchsummary
pip install tensorboardx
pip install scikit-image==0.16.2
mkdir /scratch/yz87
rm -r /scratch/yz87/models/
rm -r /scratch/yz87/test_images/
rm -r /scratch/yz87/eval_images/
mkdir /scratch/yz87/test_images/
mkdir /scratch/yz87/eval_images/
cd /scratch/yz87
if [ -f "DeepVideoDeblurring_Dataset_Original_High_FPS_Videos.zip"  ]; then
    echo "Dataset downloaded"
else
    wget http://www.cs.ubc.ca/labs/imager/tr/2017/DeepVideoDeblurring/DeepVideoDeblurring_Dataset_Original_High_FPS_Videos.zip
    unzip DeepVideoDeblurring_Dataset_Original_High_FPS_Videos.zip
fi
cd /home/cl114/yz87/spc2022/kernel-prediction-networks-PyTorch/
python dataset_test.py
rm -r /scratch/yz87/test_images/.DS_Store/
mkdir /scratch/yz87/models
cd /home/cl114/yz87/spc2022/kernel-prediction-networks-PyTorch/
python train_eval_syn.py --cuda --config_file kpn_128/kpn_config-${job}.conf --train_dir /scratch/yz87/test_images/ --mGPU --restart
wait
