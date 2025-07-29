#!/bin/bash
#SBATCH --job-name=w51_2015_b6_lb
#SBATCH --account=adamginsburg
#SBATCH --output=w51_2015_b6_lb_%j.log
#SBATCH --mail-user=adamginsburg@ufl.edu
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=96gb
#SBATCH --time=4-00:00:00
#SBATCH --qos=adamginsburg-b

export FIELD_ID='W51'
export BAND_TO_IMAGE='B6'
export LOGFILENAME='casa_log_w51lbcont_${FIELD_ID}_${BAND_TO_IMAGE}_12M_$(date +%Y-%m-%d_%H_%M_%S).log'
export CASA='/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'

export FIELD_ID="W51"
export BAND_TO_IMAGE=B6
export LOGFILENAME="casa_log_w51lbcont_${FIELD_ID}_${BAND_TO_IMAGE}_12M_$(date +%Y-%m-%d_%H_%M_%S).log"
WORK_DIR='/orange/adamginsburg/w51/w51-alma-longbaseline'
export CASA=/orange/adamginsburg/casa/casa-release-5.6.0-60.el7/bin/casa
export CASA=/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
module load git
which python
which git
git --version
echo $?
imaging_script=/orange/adamginsburg/w51/W51_ALMA_2013.1.00308.S/script_longbaseline_b6/script_longbaseline_big.py
cd ${WORK_DIR}
echo ${WORK_DIR}
echo "Logfilename is ${LOGFILENAME}"
echo xvfb-run -d ${CASA} --nogui --nologger --logfile=${LOGFILENAME} -c "execfile('${imaging_script}')"
xvfb-run -d ${CASA} --nogui --nologger --logfile=${LOGFILENAME} -c "execfile('${imaging_script}')"
