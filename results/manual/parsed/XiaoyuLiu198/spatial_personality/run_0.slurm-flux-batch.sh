#!/bin/bash
#FLUX: --job-name=twi_infer_t
#FLUX: -c=16
#FLUX: --gpus-per-task=4
#FLUX: --queue=gpuA100x4
#FLUX: -t=57600
#FLUX: --urgency=16

current_date_time="`date +%Y%m%d%H%M%S`"
echo $current_date_time
module load anaconda3_gpu
module load cuda
git clone https://github.com/ztxz16/fastllm
cd fastllm
mkdir build
cd build
cmake .. -DUSE_CUDA=ON
make -j
cd tools && python setup.py install
cd ..
cd ..
git clone https://github.com/XiaoyuLiu198/spatial_personality.git
cd spatial_personality
mkdir results
mkdir twitter_prompts
mkdir ckpts
pip install -r requirements.txt
cd twitter_prompts
wget  --no-check-certificate 'https://docs.google.com/uc?export=download&id=1CQDDqHfiZc8inKrXARu6dCEZdqY72373' -O post_sample_1198.csv
readlink -f post_sample_1198.csv
cd ..
cd ckpts
pip uninstall gdown
pip install gdown==4.6.0
gdown https://drive.google.com/uc?id=1JTkg-z211GusTeY-ZU-IIQcq7wy1ovDr
unzip conscientiousness_ckpts.zip
cd ..
python single.py --file /twitter_prompts/ --checkpoint /ckpts/content/drive/MyDrive/twitter_inference_data/ckpts/conscientiousness --destination /results/ --start 1198 --end 1199
current_date_time="`date +%Y%m%d%H%M%S`"
echo $current_date_time
