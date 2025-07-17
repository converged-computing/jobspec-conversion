#!/bin/bash
#FLUX: --job-name=angry-kerfuffle-7086
#FLUX: -t=36000
#FLUX: --urgency=16

name=`echo $1`
user=`echo $2`
cd /fs/ess/PAS0854/Active_projects/`echo $name`
module load R/4.1.0-gnu9.1
cond=`squeue -u $user | wc -l`
while IFS= read line;
do
    while [ $cond -ge 999 ];
    do
        #if we are, wait 30 min and check again
        echo "Waiting: Download";
        Rscript /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/waiting.R;
        cond=`squeue -u $user | wc -l`
    done;
sbatch /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/dxTrust41ata.sh `echo $line` `echo $name`;
cond=`squeue -u $user | wc -l`
done < RNAseqBams.TCGA.txt
cond=`squeue -u $user | wc -l`
while IFS= read line;
do
while [ $cond -ge 999 ];
    do
        #if we are, wait 30 min and check again
        echo "Waiting: Download";
        Rscript /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/waiting.R;
        cond=`squeue -u $user | wc -l`
    done;
sbatch /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/dxTrust4Orien1ata.sh `echo $line` `echo $name`;
cond=`squeue -u $user | wc -l`
done < RNAseqBams.Orien.txt
Rscript /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/waiting.R
cond=`squeue -u $user | grep 'dxTr' | wc -l`
while [ $cond -gt 0 ];
do
    echo "Waiting: Download";
    Rscript /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/waiting.R; 
    cond=`squeue -u $user | grep 'dxTr' | wc -l`;
done
rm slurm-*
Rscript /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/Trust4Analysis.R `echo $name`
