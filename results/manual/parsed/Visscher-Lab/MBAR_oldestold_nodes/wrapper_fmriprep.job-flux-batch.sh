#!/bin/bash
#FLUX: --job-name=fmriprep_$patient
#FLUX: -c=5
#FLUX: --queue=long
#FLUX: -t=360000
#FLUX: --priority=16

export SINGULARITY_BINDPATH='/data/project/vislab'

jobs=/data/project/vislab/a/MBAR/Resting_preproc/fmriprep_jobs
logs=/data/project/vislab/a/MBAR/Resting_preproc/fmriprep_logs
mkdir $jobs
mkdir $logs
D=/data/project/vislab/a/MBAR/Anat_preproc/AllSites_BIDS/
for patient in `ls -1 $D`
do
echo "#!/bin/bash
module load Singularity/2.5.2-GCC-5.4.0-2.26 
export SINGULARITY_BINDPATH=/data/project/vislab
cd /data/project/vislab/MISC/Scripts/fmriprep/
singularity run fmriprep-1.2.5.simg --output-space T1w template --verbose --fs-license license.txt --skip_bids_validation -t rest --n_cpus 5 --omp-nthreads 5 -w /data/project/vislab/a/MBAR/Resting_preproc/workdir /data/project/vislab/a/MBAR/Anat_preproc/AllSites_BIDS/ /data/project/vislab/a/MBAR/Anat_preproc/derivatives/ participant --participant_label $patient" > $jobs/fmriprep_$patient.job
sbatch $jobs/fmriprep_$patient.job
done
