#!/bin/bash
#FLUX: --job-name=purple-cat-4394
#FLUX: -n=4
#FLUX: --queue=alvis
#FLUX: -t=7200
#FLUX: --urgency=16

data_set="data_Olga-Tokarczuk.npz"
archive="VA-classification"
data_set="data_"$2".npz"
classifier=$1
itr="_itr_"$3
train_idx="train-idx-val.npy"
test_idx="test-idx-val.npy"
train_idx="indices.npz"
test_idx=""
cp -r $HOME/motion-analysis $TMPDIR
cp -r $HOME/datasets $TMPDIR
cd $TMPDIR
mkdir results
module purge
module load GCC/8.3.0 CUDA/10.1.243 OpenMPI/3.1.4 cuDNN/7.6.4.38
module load SciPy-bundle/2019.10-Python-3.7.4 matplotlib/3.1.1-Python-3.7.4
virtualenv train-class
source train-class/bin/activate
pip install tensorflow==2.3.1
pip install keras==2.4
pip install -U --no-deps git+https://github.com/ck37/coral-ordinal/
pip install focal-loss
cd motion-analysis/classification/tsc
pip install -r utils/requirements-cluster.txt
python train-model.py $TMPDIR/results $TMPDIR/datasets/$data_set $classifier --itr $itr --idx $TMPDIR/motion-analysis/classification/tsc/idx2.npz
cp -r $TMPDIR/results/. $HOME/deploy/
