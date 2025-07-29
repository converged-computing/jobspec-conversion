#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=120G
#SBATCH --time=1-00:00:00
#SBATCH --partition=ghpc

TMPDIR=/scratch/$USER/$SLURM_JOBID
export TMPTDIR
mkdir -p $TMPDIR
source activate picrust2
add_descriptions.py -i ./functional_analysis/KO_metagenome/functionKEGG_Pathways/path_abun_unstrat.tsv --custom_map_table ./functional_analysis/KO_metagenome/KEGG_pathways_info.tsv -o ./functional_analysis/KO_metagenome/functionKEGG_Pathways/path_abun_unstrat_descrip.tsv
cd $SLURM_SUBMIT_DIR
rm -rf /scratch/$USER/$SLURM_JOBID
