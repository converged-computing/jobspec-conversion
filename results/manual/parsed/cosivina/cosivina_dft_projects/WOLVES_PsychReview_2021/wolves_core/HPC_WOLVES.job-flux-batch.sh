#!/bin/bash
#FLUX: --job-name=matlab-WOLVES_job
#FLUX: -t=345600
#FLUX: --urgency=16

module add matlab/2020a
matlab -nodisplay -nosplash -singleCompThread -r XSIT_Manual_run
