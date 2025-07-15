#!/bin/bash
#FLUX: --job-name=baker_preprocessing_0_single
#FLUX: -c=12
#FLUX: --queue=20
#FLUX: -t=86400
#FLUX: --urgency=16

source /lab/barcheese01/mdiberna/OpticalPooledScreens_david/venv/bin/activate
cd /lab/barcheese01/screens/baker/preprocessing_0
python3 preprocessing_single.py
