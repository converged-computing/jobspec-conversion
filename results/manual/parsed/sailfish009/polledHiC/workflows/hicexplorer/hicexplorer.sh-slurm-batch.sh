#!/bin/bash
#SBATCH --job-name=snakemake_hicexplorer
#SBATCH --output=snakemake_hicexplorer.log
#SBATCH --error=snakemake_hicexplorer.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G

module purge
module load system/Miniconda3-4.7.10
module load system/Python-3.7.4
echo "Creation of sampled protocols table"
sleep 0.4s ; echo -n '-' ; sleep 0.4s ; echo -n '-' ; sleep 0.4s ; echo -n '-' ; sleep 0.4s ; echo '-'
python make_sampled_protocol.py
echo "DONE"
sleep 0.4s
echo "=== sampled_protocols.sv ==="
cat sampled_protocols.tsv
echo ""
sleep 0.4s
echo "Run of Snakemake"
sleep 0.4s ; echo -n '-' ; sleep 0.4s ; echo -n '-' ; sleep 0.4s ; echo -n '-' ; sleep 0.4s ; echo '-'
snakemake --jobs 1 -p -n\
  --snakefile /work2/genphyse/dynagen/jmartin/polledHiC/workflows/hicexplorer_jm/Snakefile \
  --directory /work2/genphyse/dynagen/jmartin/polledHiC/workflows/hicexplorer_jm/
echo "DONE"
echo ""
