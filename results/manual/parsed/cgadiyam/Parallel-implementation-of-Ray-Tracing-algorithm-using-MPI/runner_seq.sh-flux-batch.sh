#!/bin/bash
#FLUX: --job-name=hairy-signal-6146
#FLUX: --priority=16

./raytrace_seq -h 5000 -w 5000 -c configs/box.xml -p none
