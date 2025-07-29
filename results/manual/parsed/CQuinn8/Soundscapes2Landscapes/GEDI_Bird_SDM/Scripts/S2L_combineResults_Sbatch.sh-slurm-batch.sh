#!/bin/bash
#FLUX: --job-name=S2L_combineRes
#FLUX: --queue=all
#FLUX: -t=600
#FLUX: --urgency=16

baseResPath='/scratch/pb463/projects/S2L/SDM/results/s20200113/All_woutGEDI/'
specRun="ACWO AMGO BEWR BHGR BLPH BRBL BUSH CALT CAQU CBCH DEJU HOFI LEGO MODO NOFL NOMO NUWO OATI RWBL SOSP SPTO STJA WCSP WEBL WESJ"
cd $baseResPath
cd mergedResults'/'
s=$(echo $specRun | cut -d " " -f $SLURM_ARRAY_TASK_ID)
outImp=$s'_imp_merged.csv'
head -1 ../250M/$s*'_250M_'*'i1_modelResults_Optimized_imp.csv' > $outImp
tail -n +2 -q ../250M/$s*'_imp.csv' >> $outImp
tail -n +2 -q ../500M/$s*'_imp.csv' >> $outImp
tail -n +2 -q ../1000M/$s*'_imp.csv' >> $outImp
outGOF=$s'_gof_merged.csv'
head -1 ../250M/$s'_250M_'*'i1_modelResults_Optimized_gof.csv' > $outGOF
tail -n +2 -q ../250M/$s*'_gof.csv' >> $outGOF
tail -n +2 -q ../500M/$s*'_gof.csv' >> $outGOF
tail -n +2 -q ../1000M/$s*'_gof.csv' >> $outGOF
