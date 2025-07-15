#!/bin/bash
#FLUX: --job-name=boopy-ricecake-9233
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --priority=16

module load caffe
echo STARTING AT `date`
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip -m lmdb/color-50-50/mean.binaryproto  lmdb/color-50-50/train.txt lmdb/color-50-50/train_db 256 256
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip  lmdb/color-50-50/test.txt lmdb/color-50-50/test_db 256 256
