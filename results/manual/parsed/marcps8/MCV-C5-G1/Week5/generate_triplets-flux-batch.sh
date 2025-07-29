#!/bin/bash
#FLUX --job-name=goodbye-nalgas-8291
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python triplets_generator.py
