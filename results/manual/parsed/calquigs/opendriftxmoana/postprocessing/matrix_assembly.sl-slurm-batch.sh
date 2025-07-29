#!/bin/bash
#SBATCH --job-name=bigmomma_assembly_test
#SBATCH --account=vuw03073
#SBATCH --output=slurmOut/bigmomma_assembly_test.%j.txt
#SBATCH --mail-user=calquigs@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=30G
#SBATCH --time=02:00:00
#SBATCH --array=13

export SLURM_EXPORT_ENV='ALL'

export SLURM_EXPORT_ENV=ALL
module purge
module load Miniconda3
source activate opendrift_simon
echo wtf
regions=('taranaki' 'waikato' '90milebeach' 'northland' 'hauraki' 'bay_o_plenty' 'east_cape' 'hawkes_bay' 'wairarapa' 'wellington' 'marlborough' 'kahurangi' 'west_coast' 'fiordland' 'southland' 'stewart_isl' 'otago' 'canterbury' 'kaikoura' 'chatham' 'auckland_isl')
python /nesi/project/vuw03073/testScripts/matrix_assembly.py ${regions[${SLURM_ARRAY_TASK_ID}]}
