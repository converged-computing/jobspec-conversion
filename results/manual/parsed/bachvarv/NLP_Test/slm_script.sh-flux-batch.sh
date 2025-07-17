#!/bin/bash
#FLUX: --job-name=Simple_Language_Model
#FLUX: -t=72000
#FLUX: --urgency=16

rhrk-singularity tensorflow_22.03-tf2-py3.simg python3 simple_language_model_test.py
