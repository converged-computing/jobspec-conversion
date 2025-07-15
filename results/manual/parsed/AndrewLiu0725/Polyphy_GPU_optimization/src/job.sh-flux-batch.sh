#!/bin/bash
#FLUX: --job-name=frigid-car-7443
#FLUX: --priority=16

module load intel/2018
module load nvidia/cuda/10.0
/home/ajl870725/cudaDPLB_v0.1_wip/src/dplbe
