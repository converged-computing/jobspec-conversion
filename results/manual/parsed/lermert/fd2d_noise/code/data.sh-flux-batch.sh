#!/bin/bash
#FLUX: --job-name=data
#FLUX: --queue=fichtner_compute
#FLUX: -t=7200
#FLUX: --priority=16

module load matlab/r2015a
matlab -nodisplay -singleCompThread -r calculate_data
