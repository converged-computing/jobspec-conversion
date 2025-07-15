#!/bin/bash
#FLUX: --job-name=arid-nalgas-8990
#FLUX: --priority=16

matlab -nosplash -nodesktop -nodisplay -r "video_test('test_mv_$SLURM_ARRAY_TASK_ID.mp4');exit" 2>/dev/null
