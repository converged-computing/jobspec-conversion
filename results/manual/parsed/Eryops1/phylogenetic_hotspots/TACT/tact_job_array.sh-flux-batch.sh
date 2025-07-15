#!/bin/bash
#FLUX: --job-name=TACT_3rd
#FLUX: --queue=normal
#FLUX: -t=432000
#FLUX: --priority=16

source ~/miniconda3/bin/activate tact
echo -e "\nrunning TACT\n"
singularity exec tact.sif  tact_add_taxa --backbone gbmb_matched_monophyletic_orders.tre --taxonomy goodsp_wcp_2022_forTACT.taxonomy.tre --output output/gbmb_matched_monophyletic_orders_$SLURM_JOB_ID-$SLURM_ARRAY_TASK_ID.tacted --verbose
echo -e "\nfinished TACT\n"
