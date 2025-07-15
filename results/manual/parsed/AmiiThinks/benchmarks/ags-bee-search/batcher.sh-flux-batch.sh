#!/bin/bash
#FLUX: --job-name=evasive-puppy-7780
#FLUX: -t=1440
#FLUX: --urgency=16

module load python/3 cuda cudnn
source tensorflow/bin/activate
cd src/
python3 bee.py -t ${t} -d 0 -l ${t}_${a}_${m}.log -m bustle_model_0${m}.hdf5 -b bustle_benchmarks.txt -a "${a}" -p 14000000
