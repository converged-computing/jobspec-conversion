#!/bin/bash
#FLUX: --job-name=angry-hope-9154
#FLUX: -c=4
#FLUX: -t=300
#FLUX: --urgency=16

export APPTAINERENV_FS_LICENSE='$my_licence_fs'

cd
module load apptainer/1.1 nixpkgs/16.09  StdEnv/2020 freesurfer/5.3.0 StdEnv/2023 fsl
project=~/projects/def-afyshe-ab/jamesmck/bird_data_analysis
sub_num="05"
cp ${project}/data/raw_data/sub_${sub_num}.tar.gz $SLURM_TMPDIR/
tar -xzf $SLURM_TMPDIR/sub_${sub_num}.tar.gz -C $SLURM_TMPDIR
mkdir $SLURM_TMPDIR/work
mkdir $SLURM_TMPDIR/sub_${sub_num}_out
mkdir $SLURM_TMPDIR/image
cp ${project}/dataset_description.json $SLURM_TMPDIR/sub_${sub_num}_out/
cp ${project}/dataset_description.json $SLURM_TMPDIR/
cp ${project}/dataset_description.json $SLURM_TMPDIR/fmri_processing/data
cp ${project}/license.txt $SLURM_TMPDIR/
singularity run --cleanenv \
    -B $SLURM_TMPDIR/fmri_processing/data:/raw \
    -B $SLURM_TMPDIR/sub_${sub_num}_out:/output \ ## output and raw are bound, raw contains the data, output contains dataset_description
    -B ${project}/license.txt:/license/license.txt \
    -B $SLURM_TMPDIR/work:/work \
    ${project}/fmriprep.simg \
    /raw /output participant \
    --participant-label ${sub_num} \
    --work-dir /work \
    --fs-license-file /license/license.txt \
    --output-spaces fsaverage \
    --stop-on-first-crash \
tar -czf $SLURM_TMPDIR/sub_${sub_num}_out.tar.gz -C $SLURM_TMPDIR/ sub_${sub_num}_out
cp $SLURM_TMPDIR/sub_${sub_num}_out.tar.gz ${project}/data/processed/
singularity run --cleanenv -B $SLURM_TMPDIR/fmri_processing/results/TC2See:/raw -B $SLURM_TMPDIR/sub_${sub_num}_out:/output -B $SLURM_TMPDIR/work:/work ${project}/fmriprep.simg /raw /output participant --participant-label ${sub_num} --work-dir /work --fs-license-file ${project}/license.txt --output-spaces fsaverage --stop-on-first-crash 
cd
module load apptainer/1.1 nixpkgs/16.09  StdEnv/2020 freesurfer/5.3.0 StdEnv/2023 fsl
project=~/projects/def-afyshe-ab/jamesmck/bird_data_analysis
sub_num="05"
cp ${project}/data/raw_data/sub_${sub_num}.tar.gz $SLURM_TMPDIR/
tar -xzf $SLURM_TMPDIR/sub_${sub_num}.tar.gz -C $SLURM_TMPDIR/
mkdir $SLURM_TMPDIR/work
mkdir $SLURM_TMPDIR/sub_${sub_num}_out
mkdir $SLURM_TMPDIR/image
mkdir $SLURM_TMPDIR/license
cp ${project}/dataset_description.json $SLURM_TMPDIR/fmri_processing/results/TC2See
cp ${project}/fmriprep.simg $SLURM_TMPDIR/image
cp ${project}/license.txt $SLURM_TMPDIR/license
echo "\nSing run....\n"
singularity run --cleanenv \
    -B $SLURM_TMPDIR/fmri_processing/results/TC2See:/raw \
    -B $SLURM_TMPDIR/sub_${sub_num}_out:/output \
    -B $SLURM_TMPDIR/work:/work \
    -B $SLURM_TMPDIR/image:/image \
    -B $SLURM_TMPDIR/license:/license \
    /image/fmriprep.simg \
    /raw /output participant \
    --participant-label ${sub_num} \
    --work-dir /work \
    --fs-license-file /license/license.txt \
    --output-spaces fsaverage \
    --stop-on-first-crash \
singularity run --cleanenv -B /project:/project -B $SLURM_TMPDIR/fmri_processing/results/TC2See:/raw -B $SLURM_TMPDIR/sub_${sub_num}_out:/output -B $SLURM_TMPDIR/work:/work -B $SLURM_TMPDIR/image:/image -B $SLURM_TMPDIR/license:/license /image/fmriprep.simg /raw /output participant --participant-label ${sub_num} --work-dir /work --fs-license-file /license/license.txt --output-spaces fsaverage --stop-on-first-crash 
cd
module load apptainer/1.1 nixpkgs/16.09 StdEnv/2020 freesurfer/5.3.0 StdEnv/2023 fsl
project=~/projects/def-afyshe-ab/jamesmck/bird_data_analysis
sub_num=05
cp ${project}/data/raw_data/sub_${sub_num}.tar.gz ~/scratch/
tar -xzf ~/scratch/sub_${sub_num}.tar.gz -C ~/scratch
mkdir ~/scratch/work
mkdir ~/scratch/sub_${sub_num}_out
cp ${project}/dataset_description.json ~/scratch/fmri_processing/results/TC2See
cp ${project}/license.txt ~/scratch
my_licence_fs=${project}/license.txt
my_singularity_img=${project}/fmriprep.simg
my_work=~/scratch/work
my_input=~/scratch/fmri_processing/results/TC2See
my_output=~/scratch/sub_${sub_num}_out
export APPTAINERENV_FS_LICENSE=$my_licence_fs
apptainer exec --cleanenv -B /project:/project -B /scratch:/scratch/jamesmck ${my_singularity_img} env | grep FS_LICENSE
apptainer run --cleanenv -B /project:/project -B /scratch:/scratch/jamesmck ${my_singularity_img} ${my_input} ${my_output} participant --participant-label ${sub_num} -w ${my_work} --output-spaces fsaverage --stop-on-first-crash
cp ~/scratch/sub_${sub_num}_out.tar.gz ${project}/data/processed/
rm -r ~/scratch/fmri_processing  ~/scratch/license.txt  ~/scratch/sub_${sub_num}_out  ~/scratch/sub_${sub_num}_out.tar.gz  ~/scratch/sub_${sub_num}.tar.gz  ~/scratch/work
================================================================
cd
module load apptainer/1.1 nixpkgs/16.09  StdEnv/2020 freesurfer/5.3.0 StdEnv/2023 fsl
project=~/projects/def-afyshe-ab/jamesmck/bird_data_analysis
sub_num="05"
cp ${project}/data/raw_data/sub_${sub_num}.tar.gz $SLURM_TMPDIR/
tar -xzf $SLURM_TMPDIR/sub_${sub_num}.tar.gz -C $SLURM_TMPDIR/
mkdir $SLURM_TMPDIR/work
mkdir $SLURM_TMPDIR/sub_${sub_num}_out
mkdir $SLURM_TMPDIR/image
mkdir $SLURM_TMPDIR/license
cp ${project}/dataset_description.json $SLURM_TMPDIR/fmri_processing/results/TC2See
cp ${project}/fmriprep.simg $SLURM_TMPDIR/image
cp ${project}/license.txt $SLURM_TMPDIR/license
apptainer run  --cleanenv \
-B $SLURM_TMPDIR/fmri_processing/results/TC2See:/raw \
-B $SLURM_TMPDIR/sub_${sub_num}_out:/output \
-B $SLURM_TMPDIR/work:/work \
-B $SLURM_TMPDIR/image:/image \
-B $SLURM_TMPDIR/license:/license \
-B ${project}:/project \
$SLURM_TMPDIR/image/fmriprep.simg \
/raw /output participant \
--participant-label ${sub_num} \
--work-dir /work \
--fs-license-file $SLURM_TMPDIR/license/license.txt \
--output-spaces fsaverage \
--stop-on-first-crash \
tar -czf $SLURM_TMPDIR/sub_${sub_nui}_out.tar.gz -C $SLURM_TMPDIR sub_${sub_num}_out
cp $SLURM_TMPDIR/sub_${sub_num}_out.tar.gz ${project}/data/processed/
