#!/bin/bash
#FLUX: --job-name=tempname
#FLUX: -t=172800
#FLUX: --urgency=16

module load intel
source /home/xsede/users/xs-adurden1/.bashrc
cd temppath
srun /cstor/xsede/users/xs-adurden1/terachem_xstream/terachem tempname.in > tempname.out
