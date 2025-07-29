#!/bin/bash
#SBATCH --account=SNIC2020-33-20
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:40:00

vid="025_FL_R.MOV"
cp -r $HOME/motion-analysis $TMPDIR
cp -r $HOME/vids/$vid $TMPDIR
cd $TMPDIR
mkdir results
module load GCC/8.3.0 CUDA/10.1.243 OpenMPI/3.1.4 PyTorch/1.4.0-Python-3.7.4 SciPy-bundle/2019.10-Python-3.7.4
module load OpenCV/4.2.0-Python-3.7.4 Pillow 
cd motion-analysis
./install-cluster.sh
cd pose/analysis
./run-detection-cluster.sh
cd $TMPDIR
cp -r results $HOME/results
