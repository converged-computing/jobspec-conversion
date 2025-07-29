#!/bin/bash
#SBATCH --job-name=prodigal_%j
#SBATCH --account=PAS0439
#SBATCH --output=prodigal_%j.out
#SBATCH --mail-user=yan1365,yan.1365@osu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

module load python/3.6-conda5.2
source activate prodigal-2.6.3 
START=$SECONDS
dataset=${1}
cd /fs/ess/PAS0439/MING/virome/amg_analysis/AMG_host_metabolism/host_genome/${dataset}
for f in *.fna;
do 
prodigal -i ${f}  -a prodigal/${f%.fna}.faa
done
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
