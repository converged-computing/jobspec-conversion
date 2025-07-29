#!/bin/bash
#SBATCH --job-name=bash_ab_142_spw27_3sigma_pbmask0p18
#SBATCH --output=ab_142_spw27_3sigma_pbmask0p18_%j.log
#SBATCH --mail-user=abulatek@ufl.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20gb
#SBATCH --time=1-00:00:00
#SBATCH --qos=adamginsburg-b

export LOGFILENAME='casa_clean_ab_142_spw27_3sigma_pbmask0p18.log'
export CASA='/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'
export CASA_newpath='/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'

pwd; hostname; date
export LOGFILENAME='casa_clean_ab_142_spw27_3sigma_pbmask0p18.log'
echo $LOGFILENAME
export CASA=/blue/adamginsburg/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
export CASA_newpath=/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
xvfb-run -d ${CASA_newpath} --logfile=${LOGFILENAME}  --nogui --nologger -c "execfile('/blue/adamginsburg/abulatek/brick/scripts/cleans/clean_source_ab_142_spw27.py')"
