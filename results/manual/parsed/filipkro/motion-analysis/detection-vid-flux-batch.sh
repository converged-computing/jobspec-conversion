#!/bin/bash
#FLUX: --job-name=carnivorous-animal-9058
#FLUX: --urgency=16

vid="006FL.MTS"
allow_flip="False"
save_pixels="True"
cp -r $HOME/motion-analysis $TMPDIR
cp -r $HOME/vids/$vid $TMPDIR
cd $TMPDIR
mkdir results
module purge
module load GCC/8.3.0 CUDA/10.1.243 OpenMPI/3.1.4 PyTorch/1.4.0-Python-3.7.4 SciPy-bundle/2019.10-Python-3.7.4
module load OpenCV/4.2.0-Python-3.7.4 Pillow 
virtualenv detect-vid
source detect-vid/bin/activate
cd motion-analysis
bash install/install-pose-cluster.sh
cd pose/analysis
./run-detection-cluster.sh $vid $allow_flip $save_pixels
cd $TMPDIR
cp -r results $HOME/results-w-meta
