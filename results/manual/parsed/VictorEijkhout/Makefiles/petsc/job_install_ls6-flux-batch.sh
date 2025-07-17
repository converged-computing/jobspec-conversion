#!/bin/bash
#FLUX: --job-name=petscinstalljob
#FLUX: --queue=vm-small
#FLUX: -t=28800
#FLUX: --urgency=16

module list
pwd
date
./install_all.sh -j 12 -4
