#!/bin/bash
#FLUX: --job-name=conspicuous-buttface-7450
#FLUX: -n=4
#FLUX: --queue=alvis
#FLUX: -t=18000
#FLUX: --urgency=16

cp -r $HOME/motion-analysis $TMPDIR
cp -r $HOME/data-3d $TMPDIR
data_folder=$TMPDIR/data-3d
cd $TMPDIR
mkdir results-3d-ft
module purge
module load GCC/8.3.0 CUDA/10.1.243 OpenMPI/3.1.4 PyTorch/1.4.0-Python-3.7.4 SciPy-bundle/2019.10-Python-3.7.4
module load OpenCV/4.2.0-Python-3.7.4 Pillow Anaconda3 
conda create -p $TMPDIR/detection python=3.7.4 -y
source activate $TMPDIR/detection/
cd motion-analysis
bash install/install-pose3d.sh
cd pose/VideoPose3D
python run-train-cluster-full.py -e 100 -arc 3,3,3,3,3 -b 512 -no-da -no-tta -s 1 --export-training-curves --checkpoint-frequency 10 --save_folder $TMPDIR/results-3d-ft/ --save_home $HOME/save-3d/ --lol_path $data_folder/data_2d_custom_lol-take2.npz --big_data $data_folder/big_data-orig-dims.npz --chck_load $data_folder/epoch_100-orig.bin 
cd $TMPDIR
cp -r results-3d-ft $HOME
