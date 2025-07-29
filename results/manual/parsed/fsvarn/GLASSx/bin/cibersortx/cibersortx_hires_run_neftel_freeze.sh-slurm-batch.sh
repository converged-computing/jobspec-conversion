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
-B /projects/verhaak-lab/GLASS-III/data/cibersortx/glass_20201102/:/src/data \
-B /projects/verhaak-lab/GLASS-III/results/cibersortx/hires/GLASS_neftel_freeze/:/src/outdir \
/projects/verhaak-lab/varnf/docker/CIBERSORTx/hires_latest.sif "/src/CIBERSORTxHiRes" \
--username Frederick.S.Varn.Jr.GR@dartmouth.edu \
--token  ef745da3ebf38e86c4b115ea37df2362 \
--mixture gene_tpm_matrix_all_samples.tsv \
--sigmatrix neftel_cibersortx_sig_08032020.txt \
--label 'GLASS' \
--rmbatchBmode TRUE \
--groundtruth klemm_purified_avg_ground_truth_cpm_neftel.txt \
--subsetgenes neftel_common_genes.txt \
--sourceGEPs neftel_cibersortx_cell_type_sourceGEP_08032020.txt \
--threads 12 \
--cluster  true 
