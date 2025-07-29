#!/bin/bash
#SBATCH --job-name=bash_ab_134_spw45_2sigma
#SBATCH --output=ab_134_spw45_3sigma_%j.log
#SBATCH --mail-user=abulatek@ufl.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=40gb
#SBATCH --time=1-00:00:00
#SBATCH --qos=adamginsburg-b

export LOGFILENAME='casa_clean_ab_134_spw45_2sigma.log'
export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'
export CASA6='/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa'

pwd; hostname; date
export LOGFILENAME='casa_clean_ab_134_spw45_2sigma.log'
echo $LOGFILENAME
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
export CASA6=/blue/adamginsburg/adamginsburg/casa/casa-6.1.0-118/bin/casa
xvfb-run -d ${CASA6} --logfile=${LOGFILENAME}  --nogui --nologger -c "execfile('/blue/adamginsburg/abulatek/brick/scripts/imaging/imaging_source_ab_134_spw45.py')"
