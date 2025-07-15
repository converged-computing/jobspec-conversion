#!/bin/bash
#FLUX: --job-name=SAC
#FLUX: -c=6
#FLUX: -t=840
#FLUX: --urgency=16

module load python/3.6.3
module load scipy-stack
virtualenv --no-download ~/ENV
source ~/ENV/bin/activate
pip install torch --no-index
pip install tqdm
for i in 59
do
  python main.py 0.2 6.4 2 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.2 13.5 5 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.04 6.4 2 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.04 13.5 5 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.08 6.4 2 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.08 13.5 5 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.1 6.4 2 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.1 13.5 5 ../data/added_hhdata_"$i"_2.csv
done
