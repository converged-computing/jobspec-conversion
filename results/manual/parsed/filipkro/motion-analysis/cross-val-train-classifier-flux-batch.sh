#!/bin/bash
#FLUX: --job-name=expressive-caramel-1680
#FLUX: --priority=16

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
module load SciPy-bundle/2020.11-fosscuda-2020b matplotlib/3.3.3-fosscuda-2020b
virtualenv train-class
source train-class/bin/activate
pip install protobuf==3.13.0
pip install tensorflow==2.3.1
pip install keras==2.4
pip install -U --no-deps git+https://github.com/filipkro/coral-ordinal/
pip install focal-loss
cd motion-analysis/classification/tsc
pip install -r utils/requirements-cluster.txt
python -V
python -c"import tensorflow as tf;print(tf.__version__)"
python cross-val-train-classifier.py $TMPDIR/results $TMPDIR/datasets/$data_set $classifier --itr $itr --idx $TMPDIR/motion-analysis/classification/tsc/idx.npz
cp -r $TMPDIR/results/. $HOME/training/
