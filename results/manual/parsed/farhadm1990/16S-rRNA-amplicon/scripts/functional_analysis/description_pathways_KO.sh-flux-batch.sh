#!/bin/bash
#FLUX: --job-name=milky-ricecake-1305
#FLUX: --priority=16

TMPDIR=/scratch/$USER/$SLURM_JOBID
export TMPTDIR
mkdir -p $TMPDIR
source activate picrust2
add_descriptions.py -i ./functional_analysis/KO_metagenome/functionKEGG_Pathways/path_abun_unstrat.tsv --custom_map_table ./functional_analysis/KO_metagenome/KEGG_pathways_info.tsv -o ./functional_analysis/KO_metagenome/functionKEGG_Pathways/path_abun_unstrat_descrip.tsv
cd $SLURM_SUBMIT_DIR
rm -rf /scratch/$USER/$SLURM_JOBID
