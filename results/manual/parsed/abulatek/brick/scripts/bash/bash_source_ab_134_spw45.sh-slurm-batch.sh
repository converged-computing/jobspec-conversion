#!/bin/bash
#FLUX: --job-name=bash_ab_134_spw45_2sigma
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

export LOGFILENAME='casa_clean_ab_134_spw45_2sigma.log'
export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'
export CASA6='/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa'

pwd; hostname; date
export LOGFILENAME='casa_clean_ab_134_spw45_2sigma.log'
echo $LOGFILENAME
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
export CASA6=/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa
xvfb-run -d ${CASA6} --logfile=${LOGFILENAME}  --nogui --nologger -c "execfile('/blue/adamginsburg/abulatek/brick/scripts/imaging/imaging_source_ab_134_spw45.py')"
