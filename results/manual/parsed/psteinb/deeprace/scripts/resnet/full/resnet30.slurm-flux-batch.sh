#!/bin/bash
#FLUX: --job-name=carnivorous-fork-9396
#FLUX: -t=36000
#FLUX: --priority=16

cd /home/steinba/development/deeprace/
pwd
module load modenv/both modenv/eb tensorflow/1.3.0-Python-3.5.2 docopt/0.6.2 keras/2.1.4 h5py/2.6.0-intel-2016.03-GCC-5.3-Python-3.5.2-HDF5-1.8.17-serial
python3 ./deeprace.py train -c "k80:1,fs:nfs" -t /home/steinba/development/deeprace/scripts/full/full-resnet32v1.tsv resnet32v1
