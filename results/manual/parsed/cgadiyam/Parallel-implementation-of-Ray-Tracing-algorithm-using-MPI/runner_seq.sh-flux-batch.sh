#!/bin/bash
#FLUX: --job-name=rt_seq
#FLUX: --queue=class
#FLUX: --urgency=16

./raytrace_seq -h 5000 -w 5000 -c configs/box.xml -p none
