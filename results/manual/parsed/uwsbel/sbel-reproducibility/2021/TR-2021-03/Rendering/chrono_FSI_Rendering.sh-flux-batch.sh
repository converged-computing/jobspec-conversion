#!/bin/bash
#FLUX: --job-name=stanky-malarkey-5275
#FLUX: -c=10
#FLUX: --queue=sbel
#FLUX: -t=864000
#FLUX: --priority=16

/srv/home/whu59/research/chrono_related_package/blender-2.91.0-linux64/blender --background --python ./blender.py
