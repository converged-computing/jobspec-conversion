#!/bin/bash
#FLUX: --job-name=reclusive-cat-5905
#FLUX: --urgency=16

module load Anaconda3
conda activate /home/skrix/virtualenv_nodgltorch
module load CUDA/11.0.228
 python -m torch.utils.collect_env
cd /home/bio/groupshare/sophia/mavo
python -m redrugnn linkpredict prepare-deepwalk --which_graph=complete_graph
deepwalk --input /home/skrix/results_multigml/graph_edgelist.tsv  --output /home/skrix/results_multigml/deepwalk_embeddings.tsv --format edgelist
python -m redrugnn linkpredict run-best-hp --use_cuda=True --n_epochs=30 --evaluate_every=5 --which_graph=complete_graph --best_params_file=/home/skrix/results_multigml/graphcomplete_graph_64/best_params.json
"runme.sh" 42L, 1580C                                                                                                       33,1       Anfang
