#!/bin/bash
#FLUX: --job-name=reclusive-puppy-4686
#FLUX: -c=6
#FLUX: -t=87770
#FLUX: --urgency=16

module load StdEnv/2020 python/3.7 cuda cudnn  
SOURCEDIR=/home/shibin2/projects/def-janehowe/shibin2
DATADIR=/home/shibin2/projects/def-janehowe/shared_2022/dataset/CCMV
RESULT=/home/shibin2/projects/def-janehowe/shared_2022/output/CCMV2
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip3 install --no-index --upgrade pip
pip3 install --no-index torch==1.8.0
pip3 install --no-index pillow
pip3 install --no-index matplotlib
pip3 install --no-index tensorboard
pip3 install --no-index tensorboardX
pip3 install --no-index scipy
pip3 install --no-index ninja
pip3 install --no-index pandas
pip install --no-index $SOURCEDIR/wheels/torchdiffeq-0.2.2-py3-none-any.whl
pip install --no-index torchvision
cp -rf /home/shibin2/projects/def-janehowe/shared_2022/scripts/DGP-SPR ./
cd DGP-SPR
python train_exemplar.py $DATADIR/particles.256.mrcs  --poses $DATADIR/pose.pkl --ctf $DATADIR/ctf.pkl --zdim 10 -n 101 --root $RESULT --save 'exp_exemplar'  --enc-dim 256 --enc-layers 3 --dec-dim 256 --dec-layers 3  --amp --lazy --lr 0.00005 --beta 0.1 --checkpoint 5 --batch-size 8 --prior 'exemplar' --number-cachecomponents 5000 --approximate-prior --log-interval 10000
