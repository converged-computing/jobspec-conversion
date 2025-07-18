#!/bin/bash
#FLUX: --job-name=coverm
#FLUX: -n=20
#FLUX: -t=45000
#FLUX: --urgency=16

START=$SECONDS
module load python/3.6-conda5.2
source activate /users/PAS1855/yan1365/miniconda3/envs/coverm-0.6.1
file=${1}
for f in $(cat ${file});
do  coverm contig --coupled /fs/scratch/PAS0439/lzj/mix_reads/${f}_1.fq.gz /fs/scratch/PAS0439/lzj/mix_reads/${f}_2.fq.gz --reference /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/AMG/amg_containing_contigs.fa --min-read-percent-identity 0.95 --min-read-aligned-percent 0.75 --min-covered-fraction 0.7 -m trimmed_mean --bam-file-cache-directory /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/AMG/bam_tmp --discard-unmapped -t 20 > /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/AMG/mix/${f}.txt
done
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
