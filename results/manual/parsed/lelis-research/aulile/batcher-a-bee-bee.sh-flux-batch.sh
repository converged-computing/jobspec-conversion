#!/bin/bash
#FLUX: --job-name=adorable-bike-9592
#FLUX: -t=1440
#FLUX: --urgency=16

module load python/3 cuda cudnn scipy-stack
source tensorflow/bin/activate
cd src/
if [ ${a} -eq 1 ]
then
    python3 bee.py -t ${t} -d 0 -l ${bn}_A-Bee_${t}_${a}_${m}.log -m bustle_model_0${m}.hdf5 -b "${b}" -bn "${bn}" -a "${a}" -p 14000000
else
    python3 bee.py -t ${t} -d 0 -l ${bn}_Bee_${t}_${a}_${m}.log -m bustle_model_0${m}.hdf5 -b "${b}" -bn "${bn}" -a "${a}" -p 14000000
fi
