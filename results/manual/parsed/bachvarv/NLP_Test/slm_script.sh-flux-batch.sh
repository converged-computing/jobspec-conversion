#!/bin/bash
#FLUX: --job-name=boopy-avocado-3562
#FLUX: --priority=16

rhrk-singularity tensorflow_22.03-tf2-py3.simg python3 simple_language_model_test.py
