#!/bin/bash
#FLUX: --job-name=crusty-spoon-2210
#FLUX: --priority=16

module list
pwd
date
./install_all.sh -j 50
