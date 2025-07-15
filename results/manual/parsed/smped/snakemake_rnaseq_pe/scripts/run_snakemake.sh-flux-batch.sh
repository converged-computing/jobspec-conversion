#!/bin/bash
#FLUX: --job-name=dirty-hope-2629
#FLUX: -t=14400
#FLUX: --urgency=16

CORES=8
if [ -d "/hpcfs" ]; then
	module load arch/arch/haswell
	module load arch/haswell
	module load modulefiles/arch/haswell
	HPC="/hpcfs"
else
    if [ -d "/fast" ]; then
        HPC=/fast
    else
        exit 1
    fi
fi
PROJ=${HPC}/users/a1018048/snakemake_rnaseq
micromamba activate snakemake
cd ${PROJ}
snakemake --dag > output/dag.dot
dot -Tpdf output/dag.dot > output/dag.pdf
snakemake --rulegraph > output/rulegraph.dot
dot -Tpdf output/rulegraph.dot > output/rulegraph.pdf
snakemake \
  --cores ${CORES} \
  --use-conda \
  --wrapper-prefix 'https://raw.githubusercontent.com/snakemake/snakemake-wrappers/'
bash ${PROJ}/scripts/update_git.sh
