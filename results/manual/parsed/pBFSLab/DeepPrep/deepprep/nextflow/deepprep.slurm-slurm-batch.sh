#!/bin/bash
#FLUX: --job-name=multi
#FLUX: -c=4
#FLUX: --queue=cpu1,cpu2,fat,amd1,gpu1,gpu2
#FLUX: --urgency=16

nextflow run /lustre/grp/lhslab/sunzy/anning/workspace/DeepPrep/deepprep/nextflow/deepprep.nf \
-resume \
-c /lustre/grp/lhslab/sunzy/anning/DEEPPREP_WORKDIR/nextflow.singularity.hpc.config \
--bids_dir /lustre/grp/lhslab/sunzy/BIDS/HNU \
--subjects_dir /lustre/grp/lhslab/sunzy/anning/DEEPPREP_WORKDIR/HNU_v0.0.9ubuntu22.04H/Recon \
--bold_preprocess_path /lustre/grp/lhslab/sunzy/anning/DEEPPREP_WORKDIR/HNU_v0.0.9ubuntu22.04H/BOLD \
--qc_result_path /lustre/grp/lhslab/sunzy/anning/DEEPPREP_WORKDIR/HNU_v0.0.9ubuntu22.04H/QC \
-with-report /lustre/grp/lhslab/sunzy/anning/DEEPPREP_WORKDIR/HNU_v0.0.9ubuntu22.04H/QC/report.html \
-with-timeline /lustre/grp/lhslab/sunzy/anning/DEEPPREP_WORKDIR/HNU_v0.0.9ubuntu22.04H/QC/timeline.html \
--bold_task_type rest
