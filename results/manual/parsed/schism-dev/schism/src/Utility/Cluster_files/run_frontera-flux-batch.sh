#!/bin/bash
#FLUX: --job-name=chunky-chair-7690
#FLUX: --priority=16

module list
pwd
date
ibrun ./pschism_FRONTERA_TVD-VL  5
