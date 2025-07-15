#!/bin/bash
#FLUX: --job-name=cowy-cattywampus-7252
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --priority=16

module load caffe
echo STARTING AT `date`
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip -m lmdb/segmented-50-50/mean.binaryproto  lmdb/segmented-50-50/train.txt lmdb/segmented-50-50/train_db 256 256
python create_db.py -b lmdb -s -r squash -c 3 -e jpg -C gzip  lmdb/segmented-50-50/test.txt lmdb/segmented-50-50/test_db 256 256
