#!/bin/bash
#FLUX: --job-name=nerdy-carrot-0546
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

module load caffe
echo STARTING AT `date`
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip -m lmdb/grayscale-20-80/mean.binaryproto  lmdb/grayscale-20-80/train.txt lmdb/grayscale-20-80/train_db 256 256
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip  lmdb/grayscale-20-80/test.txt lmdb/grayscale-20-80/test_db 256 256
