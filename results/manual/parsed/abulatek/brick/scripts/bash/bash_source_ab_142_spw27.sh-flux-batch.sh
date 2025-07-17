#!/bin/bash
#FLUX: --job-name=bash_ab_142_spw27_3sigma_pbmask0p18
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

export LOGFILENAME='casa_clean_ab_142_spw27_3sigma_pbmask0p18.log'
export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'
export CASA_newpath='/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'

pwd; hostname; date
export LOGFILENAME='casa_clean_ab_142_spw27_3sigma_pbmask0p18.log'
echo $LOGFILENAME
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
export CASA_newpath=/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
xvfb-run -d ${CASA_newpath} --logfile=${LOGFILENAME}  --nogui --nologger -c "execfile('/blue/adamginsburg/abulatek/brick/scripts/cleans/clean_source_ab_142_spw27.py')"
