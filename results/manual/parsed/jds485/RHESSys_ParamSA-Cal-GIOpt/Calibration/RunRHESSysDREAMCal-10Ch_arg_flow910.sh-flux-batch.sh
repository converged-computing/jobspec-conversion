#!/bin/bash
#FLUX: --job-name=swampy-signal-9963
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --urgency=16

module purge
module load gcc/7.1.0 openmpi/3.1.4 R/3.5.3 singularity python/3.6.6
Rscript /scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/RHESSysRuns/RHESSysDREAM_NoG2W_arg.R '10' '24920' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/obs/QSyn910_1.txt' '2004-10-01' '2013-09-30' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/RHESSys_Baisman30m_g74/worldfiles/worldfile.csv' '30' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/RHESSysRuns/BaismanCalibrationParameterProblemFile_NewGWBounds.csv' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/RHESSysRuns/Bais910ChainStarts_LHS10_AfterProcessing.csv' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/RHESSysRuns/' '4000' '0' '0.05' '3' '0.1' '2' '10' '10' '0' '4000' '1' '/share/resources/containers/singularity/rhessys/rhessys_v3.img' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/RHESSys_Baisman30m_g74/defs/' '10' 'BaismanCalibrationParameterProblemFile_NewGWBounds.csv' 'RHESSys_Baisman30m_g74' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/RHESSys_Baisman30m_g74/' '/scratch/js4yd/RHESSysEastCoast_Optimized/rhessys5.20.0.develop_optimsize' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/LikelihoodFun/' '-10Ch_s400' '1' '1020' '/scratch/js4yd/Bais910Hill30mDREAMzs-10Ch/obs/QSyn910_1_p.txt' '500'
