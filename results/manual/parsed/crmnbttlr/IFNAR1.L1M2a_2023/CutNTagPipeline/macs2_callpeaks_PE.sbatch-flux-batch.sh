#!/bin/bash
#FLUX: --job-name=butterscotch-chip-0810
#FLUX: -t=43200
#FLUX: --priority=16

module load python/2.7.14/MACS/2.1.1
queries=($(ls ${inDir}/*.bam | xargs -n 1 basename))
pwd; hostname; date
echo "macs2 version: "$(macs2 --version)
echo "Target file: "${queries[$SLURM_ARRAY_TASK_ID]}
echo "Control file: "${controlFile}
echo $(date +"[%b %d %H:%M:%S] Starting macs2...")
macs2 callpeak \
--format BAMPE \
--treatment ${inDir}/${queries[$SLURM_ARRAY_TASK_ID]} \
--control ${controlFile} \
--pvalue 0.01 \
--name ${queries[$SLURM_ARRAY_TASK_ID]%.sorted.bam} \
--outdir ${outDir} \
-g ${genome} \
--SPMR -B \
--call-summits
echo $(date +"[%b %d %H:%M:%S] Done!")
