#!/bin/bash
#FLUX: --job-name=job20230719115821356
#FLUX: --queue=COMPUTE1Q
#FLUX: --priority=16

docker run --gpus all -d --name=minghsuan_webtop_orange3_CLC_20230719115821356 -e PUID=1000 -e PGID=1000 -e TZ=Asia/Taipei -p 16718:3000 --shm-size="5gb" lms025187/webtop_bio_software
