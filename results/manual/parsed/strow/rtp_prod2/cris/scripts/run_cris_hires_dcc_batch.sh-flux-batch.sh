#!/bin/bash
#FLUX: --job-name=RUN_CREATE_CRIS_HR_DCC_RTP
#FLUX: --queue=high_mem
#FLUX: -t=10740
#FLUX: --priority=16

MATLAB=matlab
MATOPT=' -nojvm -nodisplay -nosplash'
echo "Executing srun of run_cris_batch"
$MATLAB $MATOPT -r "disp('>>Starting script');rtp_addpaths;cfg=ini2struct('$1');run_cris_hires_dcc_batch(cfg); exit"
echo "Finished with run_cris_batch"
