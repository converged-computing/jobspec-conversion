#!/bin/bash
#FLUX: --job-name=deepPPI%j
#FLUX: -c=10
#FLUX: --priority=16

HOMEDIR=/home/UFIP/servantie_c/deepppi/PPIpredict/deep
DATADIR=/home/UFIP/servantie_c/deepppi/PPIpredict/deep/data
LOGS=/home/UFIP/servantie_c/deepppi/PPIpredict/deep/results/ccipl
VENVDIR=/home/UFIP/servantie_c/deepppi/ccipl/venv
module purge
echo 'Chargement du module CUDA'
module load cuda/8.0.61
echo 'CUDA charge, chargement du module python'
module load python/3.6.5
echo 'preparing split files of 1M'
ls
echo 'choosing to create a test file of a certain size'
python3 data/pick_data.py -x 10 -start 12 -f data/splits/split_test_10
echo 'creating a train file of a certain size'
python3 data/pick_data.py -x 10 -start 0 -f data/splits/split_train_10
echo 'Launching a run'
python3 main.py -lr 0.001 -epochs 200 -f slurmTest1 -data data/splits/split_train_10 -gpu 0 -b 2 -model 2 -o 2 -save "save"
echo 'All done, should be ok' >> $LOGS/log
