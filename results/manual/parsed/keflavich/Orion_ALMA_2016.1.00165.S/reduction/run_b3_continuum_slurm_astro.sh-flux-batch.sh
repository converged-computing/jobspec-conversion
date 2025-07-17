#!/bin/bash
#FLUX: --job-name=bloated-poodle-2099
#FLUX: -n=8
#FLUX: --queue=bigmem
#FLUX: -t=345600
#FLUX: --urgency=16

export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'

pwd; hostname; date
module load git
which python
which git
git --version
echo $?
cd /orange/adamginsburg/orion/2016.1.00165.S/imaging
scriptpath=/orange/adamginsburg/orion/Orion_ALMA_2016.1.00165.S/reduction
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
xvfb-run -d ${CASA}  --nogui --nologger -c "execfile('${scriptpath}/continuum_imaging_b3_sep17_2020.py')"
