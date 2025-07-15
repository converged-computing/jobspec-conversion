#!/bin/bash
#FLUX: --job-name=RespiratorySoundClassification
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --priority=16

export PYTHONPATH='$PYTHONPATH:/home/usr/bin/python3 #set your corresponding python path here'

export PYTHONPATH=$PYTHONPATH:/home/usr/bin/python3 #set your corresponding python path here
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
python3  run.py --lr=0.0001 --model_type=mobilenet --num_epochs=10 --batch_size=32 # To train the mobilenet backbone based model
python3  run.py --lr=0.0001 --model_type=vgg16 --num_epochs=10 --batch_size=32 # To train the Vgg16 backbone based model
python3  run.py --lr=0.0001 --model_type=hybrid --num_epochs=10 --batch_size=32 # To train the Hybrid CNN RNN model
python3  run.py --lr=0.0001 --model_type=hybrid --num_epochs=10 --patient_id=107 --fine_tune=True --batch_size=32
