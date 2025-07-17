#!/bin/bash
#FLUX: --job-name=lovable-parsnip-9479
#FLUX: --queue=standard
#FLUX: -t=345600
#FLUX: --urgency=16

module purge
module load gcc/7.1.0 openmpi/3.1.4 R/3.5.3 singularity python/3.6.6
Rscript /sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/RHESSysRuns/RHESSysDREAM.R '39' '91574' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/TNFun/WRTDS_modifiedFunctions.R' '/scratch/js4yd/Baisman30mDREAMzs/obs/BaismanStreamflow_Feb2020Revised_Cal.txt' '/scratch/js4yd/Baisman30mDREAMzs/obs/TN_Feb2020Revised_Cal.txt' '2004-10-01' '2013-09-30' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/RHESSys_Baisman30m_g74/worldfiles/worldfile.csv' '30' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/TNFun/TabIntMod5QLQ_p5.txt' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/TNFun/TabYearMod5QLQ_p4.txt' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/TNFun/TabLogQMod5QLQ_p4.txt' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/TNFun/TabLogQ2Mod5QLQ_p4.txt' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/TNFun/TabSinYearMod5QLQ_p4.txt' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/TNFun/TabCosYearMod5QLQ_p4.txt' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/TNFun/TabLogErrMod5QLQ_p5.txt' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/RHESSysRuns/BaismanCalibrationParameterProblemFile.csv' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/RHESSysRuns/BaismanChainStarts_LHS_AfterProcessing.csv' '/sfs/lustre/bahamut/scratch/js4yd/Baisman30mDREAMzs/RHESSysRuns/' '3900' '0' '0.05' '3' '0.1' '2' '3' '3' '0' '3900' '1'
