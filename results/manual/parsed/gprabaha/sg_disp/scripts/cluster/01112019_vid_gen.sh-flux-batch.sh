#!/bin/bash
#FLUX: --job-name=01112019_2.5sd_vid_gen
#FLUX: -c=5
#FLUX: --queue=psych_week
#FLUX: -t=604800
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/gpfs/milgram/project/chang/pg496/repositories/categorical/lib/linux'

module load MATLAB/2022b
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/gpfs/milgram/project/chang/pg496/repositories/categorical/lib/linux"
matlab -r "addpath( genpath( '/gpfs/milgram/project/chang/pg496/repositories' ) ); session='01112019'; params=sg_disp.util.get_params_for_cluster(); sg_disp.cluster.generate_video_for_one_session( session, params );"
