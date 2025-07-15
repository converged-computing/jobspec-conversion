#!/bin/bash
#FLUX: --job-name=ornery-parsnip-2896
#FLUX: --urgency=16

vid="new-vids"
cp -r $HOME/motion-analysis $TMPDIR
cp -r $HOME/vids/$vid $TMPDIR
cd $TMPDIR
mkdir results
module purge
module load GCC/8.3.0 CUDA/10.1.243 OpenMPI/3.1.4 PyTorch/1.6.0-Python-3.7.4 SciPy-bundle/2019.10-Python-3.7.4
module load OpenCV/4.2.0-Python-3.7.4 Pillow
virtualenv detect
source detect/bin/activate
cd motion-analysis
bash install/install-pose-cluster.sh
python -c "import numpy as np; print('np version: ' + np.__version__)"
module load SciPy-bundle/2019.10-Python-3.7.4
cd pose/analysis
echo "runnning bash script"
./run-folder-cluster.sh $vid
cd $TMPDIR
cp -r results $HOME/poses/$vid
echo "DONE"
