#!/bin/bash
#FLUX: --job-name=adorable-lentil-1826
#FLUX: --queue=sbel
#FLUX: -t=864000
#FLUX: --priority=16

/srv/home/whu59/research/chrono_related_package/blender-2.91.0-linux64/blender --background --python ./bld_test.py
