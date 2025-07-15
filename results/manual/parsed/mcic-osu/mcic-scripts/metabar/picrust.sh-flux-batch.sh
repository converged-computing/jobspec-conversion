#!/bin/bash
#FLUX: --job-name=boopy-gato-0589
#FLUX: -t=7200
#FLUX: --urgency=16

source ~/.bashrc
[[ $(which conda) = ~/miniconda3/bin/conda ]] || module load python/3.6-conda5.2
source activate picrust2-env-source
set -euo pipefail
biom=$1
fa=$2
outdir=$3
n_proc=$SLURM_NTASKS
echo -e "\n## Starting script picrust.sh"
date
echo
echo "Input BIOM file:                    $biom"
echo "Input FASTA file:                   $fa"
echo "Output dir:                         $outdir"
echo "Number of processes:                $n_proc"
echo
[[ ! -f $biom ]] && echo "## ERROR: Input BIOM file $biom does not exist" && exit 1
[[ ! -f $fa ]] && echo "## ERROR: Input BIOM file $biom does not exist" && exit 1
picrust2_pipeline.py -s "$fa" \
                     -i "$biom" \
                     -o "$outdir" \
                     -p "$n_proc" \
                     --in_traits EC,KO \
                     --remove_intermediate \
                     --verbose
echo -e "\n## Listing output files:"
ls -lh "$outdir"
echo -e "\n## Done with script picrust.sh"
date
