#!/bin/bash
#FLUX: --job-name=nmmo2
#FLUX: -t=43200
#FLUX: --urgency=16

export TUNE_RESULT_DIR='./evo_experiment/'

cd /scratch/se2161/neural-mmo || exit
source activate
conda activate nmmo
export TUNE_RESULT_DIR='./evo_experiment/'
python Forge.py evaluate --config treeorerock --model fit-L2_skills-ALL_gene-Random_algo-MAP-Elites_0 --map fit-L2_skills-ALL_gene-Random_algo-MAP-Elites_0 --infer_idx "(18, 17, 0)" --EVALUATION_HORIZON 100 --N_EVAL 20 --NEW_EVAL --SKILLS "['constitution', 'fishing', 'hunting', 'range', 'mage', 'melee', 'defense', 'woodcutting', 'mining', 'exploration',]"
