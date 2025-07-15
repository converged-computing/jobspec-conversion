#!/bin/bash
#FLUX: --job-name=SbatchJob
#FLUX: --queue=bluemoon
#FLUX: -t=108000
#FLUX: --priority=16

cd ${SLURM_SUBMIT_DIR}
echo "Starting sbatch script myscript.sh at:`date`"
cd /users/c/p/cpetak/WGS/local_pca_pipe
Rscript ~/WGS/local_pca_pipe/run_lostruct.R -i ~/EG2023/structural_variation/backup/filtered_bcf_index_noouts/all_together -t snp -s 100000 -I ~/WGS/local_pca_pipe/sample_info_noouts.tsv -o ~/WGS/local_pca_pipe/lostruct_results_noouts/type_snp_size_${snp}_all_chromosomes
