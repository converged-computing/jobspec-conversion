#!/bin/bash
#FLUX: --job-name=loopy-milkshake-7212
#FLUX: --urgency=16

module list
pwd
date
ibrun ./pschism_FRONTERA_TVD-VL  5
