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
pathway_pipeline.py -i ./functional_analysis/KO_metagenome/pred_metagenome_contrib.tsv --no_regroup -m \
./functional_analysis/KO_metagenome/KEGG_pathways_to_KO.tsv -o ./functional_analysis/KO_metagenome/functionKEGG_Pathways -p 10
cd $SLURM_SUBMIT_DIR
rm -rf /scratch/$USER/$SLURM_JOBID
