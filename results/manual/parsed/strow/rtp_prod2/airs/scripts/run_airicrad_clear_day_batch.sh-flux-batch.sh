#!/bin/bash
#FLUX: --job-name=RUN_CREATE_AIRS_CLEAR_DAY_RTP
#FLUX: --queue=high_mem
#FLUX: -t=14340
#FLUX: --priority=16

MATLAB=matlab
MATOPT=' -nojvm -nodisplay -nosplash'
echo "Executing srun of run_cris_batch"
$MATLAB $MATOPT -r "disp('>>Starting script');\
                    airs_rtpaddpaths;\
                    cfg=ini2struct('$1');\
                    run_airicrad_clear_day_batch(cfg);\
                    exit"
echo "Finished with run_airs_batch"
