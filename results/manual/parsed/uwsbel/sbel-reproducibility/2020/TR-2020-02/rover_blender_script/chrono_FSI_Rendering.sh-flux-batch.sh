#!/bin/bash
#FLUX: --job-name=phat-mango-8900
#FLUX: --queue=sbel
#FLUX: -t=864000
#FLUX: --urgency=16

/srv/home/whu59/research/chrono_related_package/blender-2.91.0-linux64/blender --background --python ./bld_test.py
