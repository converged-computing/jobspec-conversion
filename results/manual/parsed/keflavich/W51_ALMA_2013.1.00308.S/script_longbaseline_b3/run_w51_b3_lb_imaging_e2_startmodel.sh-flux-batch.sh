#!/bin/bash
#FLUX: --job-name=w51_2017_b3_lb_e2_sm
#FLUX: -n=16
#FLUX: -t=345600
#FLUX: --urgency=16

export FIELD_ID='W51'
export BAND_TO_IMAGE='B3'
export LOGFILENAME='casa_log_w51e2lbcont_sm_${FIELD_ID}_${BAND_TO_IMAGE}_12M_$(date +%Y-%m-%d_%H_%M_%S).log'
export CASA='/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'

export FIELD_ID="W51"
export BAND_TO_IMAGE=B3
export LOGFILENAME="casa_log_w51e2lbcont_sm_${FIELD_ID}_${BAND_TO_IMAGE}_12M_$(date +%Y-%m-%d_%H_%M_%S).log"
WORK_DIR='/orange/adamginsburg/w51/2017.1.00293.S/uvdata'
WORK_DIR='/orange/adamginsburg/w51/2017.1.00293.S/may2021_imaging'
export CASA=/orange/adamginsburg/casa/casa-release-5.6.0-60.el7/bin/casa
export CASA=/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
module load git
which python
which git
git --version
echo $?
imaging_script=/orange/adamginsburg/w51/W51_ALMA_2013.1.00308.S/script_longbaseline_b3/script_for_imaging_selfcal_starfromALMAIMF.py
cd ${WORK_DIR}
echo ${WORK_DIR}
pycode="field='w51e2'; cleanmask='cleanmask_e2.crtf';"
pycode="$pycode startmodel=['/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/imaging_results/W51-E_B3_uid___A001_X1296_X10b_continuum_merged_12M_robust0_selfcal7_finaliter.model.tt0', "
pycode="$pycode '/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/imaging_results/W51-E_B3_uid___A001_X1296_X10b_continuum_merged_12M_robust0_selfcal7_finaliter.model.tt1']"
echo $pycode
echo "Logfilename is ${LOGFILENAME}"
echo xvfb-run -d ${CASA} --nogui --nologger --logfile=${LOGFILENAME} -c "${pycode}; execfile('${imaging_script}')"
xvfb-run -d ${CASA} --nogui --nologger --logfile=${LOGFILENAME} -c "${pycode}; execfile('${imaging_script}')"
