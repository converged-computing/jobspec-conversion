#!/bin/bash
#FLUX: --job-name=salted-itch-2774
#FLUX: --urgency=16

source paccmann_predict/bin/activate
python /nas/longleaf/home/qhz/paccmann_predictor/examples/IC50/train_paccmann.py \
gdsc_old/mask_drug/maskdrug_train_${SLURM_ARRAY_TASK_ID}.csv \
gdsc_old/mask_drug/maskdrug_test_${SLURM_ARRAY_TASK_ID}.csv \
gdsc_old/gdsc_gene_exp.csv \
gdsc_old/gdsc_smile.smi \
data/2128_genes.pkl \
single_pytorch_model/smiles_language \
gdsc1_maskdrug \
single_pytorch_model/model_params_50.json \
"gdsc1_maskdrug_${SLURM_ARRAY_TASK_ID}"
