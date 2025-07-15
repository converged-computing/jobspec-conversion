#!/bin/bash
#FLUX: --job-name=joyous-lentil-4437
#FLUX: --urgency=16

./raytrace_seq -h 5000 -w 5000 -c configs/box.xml -p none
