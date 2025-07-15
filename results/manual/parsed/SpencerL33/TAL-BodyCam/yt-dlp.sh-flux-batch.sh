#!/bin/bash
#FLUX: --job-name=yt-dlp
#FLUX: -n=4
#FLUX: -t=10800
#FLUX: --priority=16

module load python/3.10
module list
source ENV/bin/activate
cd pages
yt-dlp --config-locations /project/6003167/slee67/bodycam/yt-dlp.conf https://vimeo.com/user51379210/videos
