#!/bin/bash
#FLUX: --job-name=misunderstood-general-2310
#FLUX: -n=10
#FLUX: --queue=ghpc
#FLUX: -t=86400
#FLUX: --urgency=16

TMPDIR=/scratch/$USER/$SLURM_JOBID
export TMPTDIR
mkdir -p $TMPDIR
source activate picrust2
pathway_pipeline.py -i ./functional_analysis/KO_metagenome/pred_metagenome_contrib.tsv --no_regroup -m \
./functional_analysis/KO_metagenome/KEGG_pathways_to_KO.tsv -o ./functional_analysis/KO_metagenome/functionKEGG_Pathways -p 10
cd $SLURM_SUBMIT_DIR
rm -rf /scratch/$USER/$SLURM_JOBID
