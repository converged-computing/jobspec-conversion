#!/bin/bash
#FLUX: --job-name=aln_eval
#FLUX: -c=8
#FLUX: -t=300
#FLUX: --urgency=16

export SINGULARITYENV_CUDA_VISIBLE_DEVICES='$CUDA_VISIBLE_DEVICES'

module purge
module load anaconda3/2020.11
conda activate vcmsa_env
module load cudatoolkit/11.3
nvidia-smi
python -m torch.utils.collect_env
export SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES
basefile=aln_evaluate_20_nopca_16layer_t5_padding10_thr90_nobc_mnc_oldclust
nextflow run $SCRATCH/github/aln_benchmarking/main.nf -params-file ${basefile}.json  -with-singularity file:///scratch/gpfs/cmcwhite//tcoffee_pdb.sif -profile singularity  -with-trace -with-timeline ${basefile}.json.report.html
