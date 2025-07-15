#!/bin/bash
#FLUX: --job-name=stac_merge
#FLUX: --priority=16

set -e
source ~/.bashrc
setup_mujoco200_3.7
stac-merge ./stac
