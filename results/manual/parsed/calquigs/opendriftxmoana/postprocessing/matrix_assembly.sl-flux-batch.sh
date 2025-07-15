#!/bin/bash
#FLUX: --job-name=bigmomma_assembly_test
#FLUX: -c=2
#FLUX: -t=7200
#FLUX: --urgency=16

export SLURM_EXPORT_ENV='ALL'

export SLURM_EXPORT_ENV=ALL
module purge
module load Miniconda3
source activate opendrift_simon
echo wtf
regions=('taranaki' 'waikato' '90milebeach' 'northland' 'hauraki' 'bay_o_plenty' 'east_cape' 'hawkes_bay' 'wairarapa' 'wellington' 'marlborough' 'kahurangi' 'west_coast' 'fiordland' 'southland' 'stewart_isl' 'otago' 'canterbury' 'kaikoura' 'chatham' 'auckland_isl')
python /nesi/project/vuw03073/testScripts/matrix_assembly.py ${regions[${SLURM_ARRAY_TASK_ID}]}
