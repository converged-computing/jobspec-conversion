#!/bin/bash
#FLUX: --job-name=stinky-hippo-1852
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

module load caffe
echo STARTING AT `date`
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip -m lmdb/color-40-60/mean.binaryproto  lmdb/color-40-60/train.txt lmdb/color-40-60/train_db 256 256
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip  lmdb/color-40-60/test.txt lmdb/color-40-60/test_db 256 256
