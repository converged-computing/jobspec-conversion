#!/bin/bash
#FLUX: --job-name=peachy-cat-7987
#FLUX: --queue=gpu2
#FLUX: -t=32400
#FLUX: --urgency=16

cd /home/steinba/development/deeprace/
pwd
module load modenv/both modenv/eb tensorflow/1.3.0-Python-3.5.2 docopt/0.6.2 keras/2.1.4 h5py/2.6.0-intel-2016.03-GCC-5.3-Python-3.5.2-HDF5-1.8.17-serial
python3 ./deeprace.py train -O batch_size=512 -c "k80:1,fs:nfs" -t /home/steinba/development/deeprace/scripts/full/full-resnet56v1-bs512.tsv resnet56v1
