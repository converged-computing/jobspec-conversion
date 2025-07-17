#!/bin/bash
#FLUX: --job-name=joyous-kitty-1808
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

module load caffe
echo STARTING AT `date`
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip -m lmdb/grayscale-50-50/mean.binaryproto  lmdb/grayscale-50-50/train.txt lmdb/grayscale-50-50/train_db 256 256
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip  lmdb/grayscale-50-50/test.txt lmdb/grayscale-50-50/test_db 256 256
