#!/bin/bash
#SBATCH --job-name=virsorter2_%j
#SBATCH --account=PAS0439
#SBATCH --output=virsorter2_%j.out
#SBATCH --mail-user=yan1365,yan.1365@osu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=02:30:00

START=$SECONDS
part=${1}
cd /fs/ess/PAS0439/MING/virome/amg_analysis/complete_viruses_splited
virsorter run --seqname-suffix-off --viral-gene-enrich-off --provirus-off --prep-for-dramv -w ../dram_annotation/${part} -i complete_viruses.part_${part}.fa -j 48 all
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
