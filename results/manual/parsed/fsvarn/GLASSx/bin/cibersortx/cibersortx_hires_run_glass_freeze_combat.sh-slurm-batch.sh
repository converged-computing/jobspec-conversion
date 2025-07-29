#!/bin/bash
#SBATCH --output=/projects/verhaak-lab/GLASS-III/logs/slurm/CIBERSORTx_HiRes.out
#SBATCH --error=/projects/verhaak-lab/GLASS-III/logs/slurm/CIBERSORTx_HiRes.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=36g
#SBATCH --time=08:00:00

module load singularity
singularity exec \
-B /projects/verhaak-lab/GLASS-III/data/cibersortx/glass_combat_20200106/:/src/data \
-B /projects/verhaak-lab/GLASS-III/results/cibersortx/hires/GLASS-combat_20200106_scgp/:/src/outdir \
/projects/verhaak-lab/varnf/docker/CIBERSORTx/hires_latest.sif "/src/CIBERSORTxHiRes" \
--username Frederick.S.Varn.Jr.GR@dartmouth.edu \
--token  ef745da3ebf38e86c4b115ea37df2362 \
--mixture gene_combat_matrix_all_samples_01062020.tsv \
--sigmatrix scgp_sig.txt \
--label 'GLASS' \
--rmbatchSmode TRUE \
--refsample 10x_scgp_cibersortx_ref_06092020.txt \
--subsetgenes glass_combat_common_genes.txt \
--threads 12 \
--cluster  true
