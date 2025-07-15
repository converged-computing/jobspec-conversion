#!/bin/bash
#FLUX: --job-name=RUN_CREATE_CRIS_HR_ALLFOV_RTP
#FLUX: --queue=batch
#FLUX: -t=7140
#FLUX: --priority=16

MATLAB=matlab
MATOPT=' -nojvm -nodisplay -nosplash'
echo "Executing srun of run_cris_batch"
$MATLAB $MATOPT -r "disp('>>Starting script');rtp_addpaths;cfg=ini2struct('$1');run_cris_hires_allfov_batch(cfg); exit"
echo "Finished with run_cris_batch"
