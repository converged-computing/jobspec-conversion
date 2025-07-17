#!/bin/bash
#FLUX: --job-name=matlab-WOLVES_job
#FLUX: --queue=ib-24-96
#FLUX: -t=345600
#FLUX: --urgency=16

module add matlab/2020a
matlab -nodisplay -nosplash -singleCompThread -r XSIT_Manual_run
