#!/bin/bash
#FLUX: --job-name=music2emotion
#FLUX: -c=6
#FLUX: --queue=cuda
#FLUX: -t=21600
#FLUX: --urgency=16

ml purge
ml nvidia/cudasdk/10.1
ml intel/python/3/2019.4.088
cd /home/mtesta/ || exit
echo "cloning creativeAI repository DONE!"
echo "moving the dataset into the data_root inside the repository"
mkdir -p /home/mtesta/creativeAI/musicSide_root_data/MusicEmo_dataset_raw_wav
if [ -z "$(ls -A /home/mtesta/creativeAI/musicSide_root_data/MusicEmo_dataset_raw_wav)" ]; then
  echo "The folder: creativeAI/musicSide_root_data/MusicEmo_dataset_raw_wav is empty... going to move the dataset into the data_root inside the repository"
  cp -R /home/mtesta/data/clips_30seconds_preprocessed_BIG /home/mtesta/creativeAI/musicSide_root_data/MusicEmo_dataset_raw_wav
else
  echo "The raw files are already inside the repo path"
fi
cd ./creativeAI || exit
cd ./creativeAI || exit
repo_root_legion="/home/mtesta/creativeAI"
code="main.py"
echo "installing modules"
pip install Tornado --user
pip install numpy==1.21.0
pip install tensorflow==2.5.0 --user
pip install ffmpeg==1.4 --user
pip install pydub==0.25.1 --user
pip install scipy --user
pip install torch==1.8.0 --user
pip install torchaudio==0.8.0 --user
pip install torchvision==0.9.0 --user
pip install tensorboard==2.5.0 --user
pip install librosa==0.8.1 --user
pip install seaborn==0.11.1 --user
echo "calling ${code}, with repo_root: ${repo_root_legion}. PWD is: $PWD"
python3 ${code} -v -r ${repo_root_legion} -mel
