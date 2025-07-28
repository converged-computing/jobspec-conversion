#!/bin/bash
#FLUX: --job-name=python-cpu
#FLUX: --queue=normal
#FLUX: -t=87055
#FLUX: --urgency=16

source vnv/geo_vnv/bin/activate
pip install spacy
pip install spacy-langdetect
python -m spacy download en
python -m spacy download bn
python -m spacy download ru
python -m spacy download zh
python -m spacy download kr
python -m spacy download fr
python -m spacy download ar
