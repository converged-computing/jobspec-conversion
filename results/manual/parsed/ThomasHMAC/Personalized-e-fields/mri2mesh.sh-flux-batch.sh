#!/bin/bash
#FLUX: --job-name="mri2mesh"
#FLUX: -c=6
#FLUX: --queue=high-moby
#FLUX: -t=108000
#FLUX: --priority=16

export SUBJECTS_DIR='/projects/ttan/UBC-TMS/simnibs/mri2mesh'

module load FSL/6.0.1
module load freesurfer/6.0.1
export SUBJECTS_DIR=/projects/ttan/UBC-TMS/simnibs/mri2mesh
study="UBC-TMS"
sublist=/projects/ttan/${study}/simnibs/rerun_sublist_v01.txt
indir=/projects/ttan/${study}/simnibs/anat
outdir=/projects/ttan/${study}/simnibs/mri2mesh
index() {
   head -n $SLURM_ARRAY_TASK_ID $sublist \
   | tail -n 1
}
sub_f=$(find ${indir}/ -type f -name "`index`_*T1w.nii.gz")
cd ${outdir}
mri2mesh --all `index` $sub_f
