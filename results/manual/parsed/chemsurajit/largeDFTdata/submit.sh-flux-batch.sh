#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=40
#FLUX: --exclusive
#FLUX: --queue=xeon40
#FLUX: -t=180000
#FLUX: --urgency=16

ulimit -s unlimited
source /home/energy/surna/anaconda3/etc/profile.d/conda.sh
conda activate sure_svol
pyscript=$1
verbose="info" # change the verbose to other level for parallel python
reactions_csv="./test_small_data/reactions.csv"
mol_csv="./Data/molecules_qm9.csv"
output_dir="./Data/"
nprocs=1
indices="Node_0.json"
if [[ $# -gt 2 ]]; then
	reactions_csv=$2
	mol_csv=$3
	output_dir=$4
	nprocs=$5
	indices=$6
    verbose=$7
fi # To understand this, refer to the automated running bash script.
echo "In submit script, parallel python reaction: $pyscript"
echo "In submit script, reactions_csv: $reactions_csv"
echo "In submit script, molecules_csv: $mol_csv"
echo "In submit script, output_dir : $output_dir"
echo "In submit script, verbose : $verbose"
echo "In submit script, indices file: $indices"
echo "In submit script, nprocs: $nprocs"
python3 $pyscript --rid_csv $reactions_csv \
    --mol_data $mol_csv \
    --out_dir $output_dir --logging $verbose \
    --nprocs $nprocs --json_id_file $indices 
echo "finished"
