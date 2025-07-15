#!/bin/bash
#FLUX: --job-name=frnk6-5
#FLUX: -n=12
#FLUX: -t=18000
#FLUX: --priority=16

module load Python/3.6.4-foss-2019a
python main.py -p ParameterSettings/params_6.json
