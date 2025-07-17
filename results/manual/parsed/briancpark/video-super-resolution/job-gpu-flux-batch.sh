#!/bin/bash
#FLUX: --job-name=muffled-eagle-4319
#FLUX: --queue=GPU-shared
#FLUX: -t=172800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:$PROJECT/anaconda3/lib'
export CUDA_HOME='/jet/packages/cuda/v11.7.1'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PROJECT/anaconda3/lib
module load cuda cudnn nvhpc
export CUDA_HOME=/jet/packages/cuda/v11.7.1
nvidia-smi
source ~/.bashrc
conda activate csc791
cd /jet/home/bpark1/csc791-025/final
MODEL="SuperResolutionTwitter"
for SR_MODEL in "IMDN" "RDN" "RFDN" "SuperResolutionByteDance" "SuperResolutionTwitter" "WDSR"
do 
    # Factor in TVM later (save the ansor version)
    # python3 final.py --mode tvm --upscale_factor 4 --model_path $PROJECT/models/${SR_MODEL}/original/4/model_epoch_100.pth
    # python3 final.py --mode onnx --upscale_factor 4 --model_path $PROJECT/models/${SR_MODEL}/original/4/model_epoch_100.pth
    python3 final.py --mode coreml --upscale_factor 4 --model_path $PROJECT/models/${SR_MODEL}/original/4/model_epoch_100.pth
    # python3 final.py --mode tensorrt --upscale_factor 4 --model_path $PROJECT/models/${SR_MODEL}/original/4/model_epoch_100.pth
done
