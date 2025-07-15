#!/bin/bash
#FLUX: --job-name=evasive-gato-1286
#FLUX: -c=36
#FLUX: --queue=normal
#FLUX: -t=86340
#FLUX: --priority=16

export OMP_NUM_THREADS='36'

export OMP_NUM_THREADS=36
module load /apps/daint/UES/easybuild/modulefiles/daint-mc
module load /apps/daint/system/modulefiles/shifter-ng/18.06.0
input_dir="/scratch/snx3000/bp000228/BIDS_dataset"
output_dir="/scratch/snx3000/bp000228/test_desikan"
participant_label="QL20120814"
n="desikan"
n_cpus=36
freesurf_license=/users/bp000228/freesurfer_license/license.txt 
task_name="rest"
aroma_melodic_dimensionality=-120
mrtrix_output=${output_dir}"/mrtrix_output"
fmriprep_output=${output_dir}"/fmriprep_output"
fmriprep_workdir=${fmriprep_output}"/tmp"
tvb_output=${output_dir}"/TVB_output"
tvb_workdir=${tvb_output}"/tmp"
mkdir -p ${output_dir} ${mrtrix_output} ${fmriprep_output} ${fmriprep_workdir} ${tvb_output} ${tvb_workdir}
 srun shifter run --mount=type=bind,source=$HOME,destination=$HOME \
                --mount=type=bind,source=${input_dir},destination=/BIDS_dataset \
                --mount=type=bind,source=${mrtrix_output},destination=/mrtrix3_out \
                --writable-volatile=/home \
                bids/mrtrix3_connectome:latest python -c "from mrtrix3 import app; app.cleanup=False; \
                import sys; sys.argv='/mrtrix3_connectome.py /BIDS_dataset /mrtrix3_out participant \
                --participant_label ${participant_label} --parcellation ${parcellation} \
                --output_verbosity 2 --template_reg ants --n_cpus ${n_cpus} --debug \
                '.split(); execfile('/mrtrix3_connectome.py')"
declare -a parcellations=("desikan" "destrieux" "hcpmmp1") 
if [[ " ${parcellations[*]} " == *"${parcellation}"* ]];
then
        # find recon-all results in temporary folder and copy them to fmriprep_output
        mrtrix_recon_all_dir=`find ${mrtrix_output} -name "mrtrix3_connectome.py*" -type d`
        mrtrix_recon_all_name="freesurfer"
        mkdir ${fmriprep_output}"/freesurfer"
        cp -r ${mrtrix_recon_all_dir}"/"${mrtrix_recon_all_name} ${fmriprep_output}"/freesurfer/sub-"${participant_label}
fi 
srun shifter run --mount=type=bind,source=$HOME,destination=$HOME \
                --mount=type=bind,source=${input_dir},destination=/BIDS_dataset \
                --mount=type=bind,source=${fmriprep_output},destination=/fmriprep_out/ \
		 --mount=type=bind,source=${fmriprep_workdir},destination=/fmriprep_workdir/ \
                --writable-volatile=/home \
                poldracklab/fmriprep:latest /usr/local/miniconda/bin/fmriprep /BIDS_dataset /fmriprep_out/ participant \
                --use-aroma --bold2t1w-dof 6 --nthreads $SLURM_CPUS_PER_TASK --omp-nthreads $SLURM_CPUS_PER_TASK \
                --output-spaces T1w MNI152NLin6Asym:res-2 fsaverage5 --participant_label ${participant_label} \
                --fs-license-file ${freesurf_license} --aroma-melodic-dimensionality ${aroma_melodic_dimensionality} -w /fmriprep_workdir
if [ -z ${mrtrix_recon_all_dir+x} ]; 
then  # mrtrix_recon_all_dir is unset and recon-all has been performed within fmriprep
        recon_all_dir=${fmriprep_output}"/freesurfer/"
        recon_all_subject_name="sub-"${participant_label}
else # mrtrix_recon_all_dir is set
        recon_all_dir=${mrtrix_recon_all_dir}
        recon_all_subject_name=${mrtrix_recon_all_name}
fi
weights_path=${mrtrix_output}"/sub-"${participant_label}"/connectome/sub-"${participant_label}"_parc-"${parcellation}"_level-participant_connectome.csv"
tracts_path=${mrtrix_output}"/sub-"${participant_label}"/connectome/sub-"${participant_label}"_parc-"${parcellation}"_meanlength.csv"
srun shifter run   --mount=type=bind,source=`dirname ${freesurf_license}`,destination=/freesurfer_license_dir/ \
		   --mount=type=bind,source=${output_dir},destination=/output_dir --mount=type=bind,source=${mrtrix_output},destination=/mrtrix3_out \
		   --mount=type=bind,source=${fmriprep_output},destination=/fmriprep_out --mount=type=bind,source=${fmriprep_workdir},destination=/fmriprep_workdir \
		   --mount=type=bind,source=${tvb_output},destination=/tvb_out --mount=type=bind,source=${tvb_workdir},destination=/tvb_workdir \
		   --mount=type=bind,source=${recon_all_dir},destination=/recon_all_dir \
	    	   --writable-volatile=/opt \
                   triebkjp/tvb_converter:latest /bin/bash -c "cp /freesurfer_license_dir/license.txt /opt/freesurfer/ && \
								mkdir -p /recon_all_dir/${recon_all_subject_name}/bem && \
								cd /recon_all_dir/${recon_all_subject_name}/bem && \
								/tvb_converter_pipeline.sh /output_dir /mrtrix3_out /fmriprep_out \
 						                /fmriprep_workdir /tvb_out /tvb_workdir /recon_all_dir ${recon_all_subject_name} \
						                ${participant_label} ${task_name} ${parcellation} ${weights_path} ${tracts_path} ${n_cpus}"
