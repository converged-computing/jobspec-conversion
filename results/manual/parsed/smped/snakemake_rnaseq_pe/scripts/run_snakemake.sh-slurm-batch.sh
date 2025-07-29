#!/bin/bash
#SBATCH --output=/home/a1018048/slurm/snakemake_rnaseq/%x_%j.out
#SBATCH --error=/home/a1018048/slurm/snakemake_rnaseq/%x_%j.err
#SBATCH --mail-user=stephen.pederson@adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64GB
#SBATCH --time=04:00:00

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
