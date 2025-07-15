#!/bin/bash
#FLUX: --job-name=boopy-hippo-9780
#FLUX: -t=259200
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

module add cuda/8.0
module add cudnn/7-cuda-8.0
export CUDA_VISIBLE_DEVICES=0,1,2,3
echo "Activating virtualenv"
source ~/fenv/bin/activate
echo "Generating dataset"
rm -rf /scratch/dheeraj2
python ~/dheeraj_code/1f/frame_split.py
echo "Organizing dataset"
cd /scratch/dheeraj2/1f/
mkdir one_frame_per_sec
mv train test one_frame_per_sec
cd one_frame_per_sec
mv test/test-gt.csv .
mv train/train.csv .
echo "Moving train files into train"
cd train
ls -1 dangerous/ | xargs -i mv dangerous/{} .
ls -1 non-dangerous/ | xargs -i mv non-dangerous/{} .
rm -rf dangerous non-dangerous
echo "Moving test files into test"
cd ../test
ls -1 dangerous/ | xargs -i mv dangerous/{} .
ls -1 non-dangerous/ | xargs -i mv non-dangerous/{} .
rm -rf dangerous non-dangerous
cd ../..
echo "The dataset now looks like this"
ls one_frame_per_sec
echo "Cleaning up the dataset by deleting empty frames"
python ~/dheeraj_code/1f/remove_empty_frames.py
echo "Getting the fastai repo"
git clone https://github.com/fastai/fastai.git
echo "Moving dataset into fastai repo"
mv one_frame_per_sec fastai/data/
echo "Moving csv files to home"
mkdir ~/1f_outputs/
cp /scratch/dheeraj2/1f/fastai/data/one_frame_per_sec/train.csv ~/1f_outputs
cp /scratch/dheeraj2/1f/fastai/data/one_frame_per_sec/test-gt.csv ~/1f_outputs
cd ~
echo "Running resnext"
python ~/dheeraj_code/1f/resnext-classifier.py
cp /scratch/dheeraj2/1f/fastai/data/one_frame_per_sec/tmp/340/models/resnext* ~/1f_outputs/
cp -r /scratch/dheeraj2/1f/fastai/data/one_frame_per_sec/resnext/ ~/1f_outputs/resnext_predictions/
echo "Running resnet"
python ~/dheeraj_code/1f/resnet34-classifier.py
cp /scratch/dheeraj2/1f/fastai/data/one_frame_per_sec/tmp/340/models/resnet* ~/1f_outputs/
cp -r /scratch/dheeraj2/1f/fastai/data/one_frame_per_sec/resnet34/ ~/1f_outputs/resnet34_predictions
echo "Running wrn"
python ~/dheeraj_code/1f/wrn-classifier.py
cp /scratch/dheeraj2/1f/fastai/data/one_frame_per_sec/tmp/340/models/wrn* ~/1f_outputs
cp -r /scratch/dheeraj2/1f/fastai/data/one_frame_per_sec/wrn/ ~/1f_outputs/wrn_predictions
