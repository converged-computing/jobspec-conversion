#!/bin/bash
#FLUX: --job-name=array_test
#FLUX: --queue=serial_requeue
#FLUX: -t=1200
#FLUX: --urgency=16

matlab -nosplash -nodesktop -nodisplay -r "video_test('test_mv_$SLURM_ARRAY_TASK_ID.mp4');exit" 2>/dev/null
