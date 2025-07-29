#!/bin/bash
#SBATCH --job-name=dram_Rgut_%j
#SBATCH --account=PAS0439
#SBATCH --output=dram_Rgut_%j.out
#SBATCH --mail-user=yan1365,yan.1365@osu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00

module load python/3.6-conda5.2
source activate dram
START=$SECONDS
cd /fs/ess/PAS0439/MING/virome/amg_analysis/AMG_host_metabolism/host_genome/Rgut
DRAM.py annotate -i '*.fna' -o ../../dram_res/Rgut/annotation
DRAM.py distill -i ../../dram_res/Rgut/annotation/annotations.tsv -o ../../dram_res/Rgut/genome_summaries --trna_path ../../dram_res/Rgut/annotation/trnas.tsv --rrna_path ../../dram_res/Rgut/annotation/rrnas.tsv
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
