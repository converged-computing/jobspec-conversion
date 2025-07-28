#!/bin/bash
#FLUX: --job-name=llama-cpp-map
#FLUX: -c=20
#FLUX: -t=1800
#FLUX: --urgency=16

if [ "$USER" == "filippo.bistaffa" ]
then
    spack load --first py-pandas
else
    module load python/3.9.9
fi
srun python3 map.py --seed $RANDOM
