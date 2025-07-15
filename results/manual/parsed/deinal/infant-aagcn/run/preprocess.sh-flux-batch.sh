#!/bin/bash
#FLUX: --job-name=placid-caramel-0115
#FLUX: --queue=small
#FLUX: -t=3600
#FLUX: --urgency=16

module load pytorch/1.13
. ./env.sh
filter.py --location helsinki -i data/raw -o data/segments
filter.py --location pisa -i data/raw -o data/segments
rotate.py --location helsinki -i data/segments -o data/preprocessed
rotate.py --location pisa -i data/segments -o data/preprocessed
mkdir -p data/preprocessed/combined
cp data/preprocessed/helsinki/*.csv data/preprocessed/combined/
cp data/preprocessed/pisa/*.csv data/preprocessed/combined/
filter.py --location helsinki -i data/raw -o data/filtered --divide
filter.py --location pisa -i data/raw -o data/filtered --divide
rotate.py --location helsinki -i data/filtered -o data/rotated
rotate.py --location pisa -i data/filtered -o data/rotated
mkdir -p data/rotated/combined
cp data/rotated/helsinki/*.csv data/rotated/combined/
cp data/rotated/pisa/*.csv data/rotated/combined/
augment.py --location helsinki -i data/rotated -o data/augmented -n 0
augment.py --location pisa -i data/rotated -o data/augmented -n 0
stream.py --location helsinki -i data/augmented -o data/streams
stream.py --location pisa -i data/augmented -o data/streams
mkdir -p data/streams/combined
cp data/streams/helsinki/*.feather data/streams/combined/
cp data/streams/pisa/*.feather data/streams/combined/
