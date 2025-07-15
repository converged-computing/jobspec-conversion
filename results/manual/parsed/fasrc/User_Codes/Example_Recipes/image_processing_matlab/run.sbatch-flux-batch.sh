#!/bin/bash
#FLUX: --job-name=frigid-chip-1948
#FLUX: --urgency=16

matlab -nosplash -nodesktop -nodisplay -r "video_test('test_mv_$SLURM_ARRAY_TASK_ID.mp4');exit" 2>/dev/null
