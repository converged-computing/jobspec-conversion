#!/bin/bash
#FLUX: --job-name=$appName
#FLUX: --queue=nocona
#FLUX: -t=36000
#FLUX: --priority=16

appName=STREAM
./init.sh ./apps/stream/stream_app_script.sh $appName
