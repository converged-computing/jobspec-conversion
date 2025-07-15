#!/bin/bash
#FLUX: --job-name=med
#FLUX: -c=8
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --priority=16

CANLABCORE_DIR="'/dartfs-hpc/rc/lab/C/CANlab/modules/CanlabCore/CanlabCore'"
SPM12_DIR="'/dartfs-hpc/rc/lab/C/CANlab/modules/spm12'"
module load matlab/r2020a
matlab -nodisplay -nosplash -batch "opengl('save','hardware'); rootgroup = settings; rootgroup.matlab.general.matfile.SaveFormat.PersonalValue = 'v7.3'; rootgroup.matlab.general.matfile.SaveFormat.TemporaryValue = 'v7.3';  addpath(${SPM12_DIR}); addpath(genpath(${CANLABCORE_DIR})); addpath(genpath('/dartfs-hpc/rc/lab/C/CANlab/labdata/projects/spacetop_projects_social/scripts/step06_SPMsingletrial')); addpath(genpath('/dartfs-hpc/rc/lab/C/CANlab/modules/MediationToolbox')); multivariate_mediation"
