#!/bin/bash
#FLUX: --job-name=grated-cinnamonbun-8154
#FLUX: -t=21600
#FLUX: --priority=16

export matlab_cpus='10'

cd $SLURM_SUBMIT_DIR
export matlab_cpus=10
module use /proj/mnhallqlab/sw/modules
module load matlab/2022b
module load r/4.2.1
datasets="bsocial"
models="decay_factorize_selective_psequate_nocensor"
for d in $datasets; do
    for m in $models; do
	export sceptic_dataset=$d
	export sceptic_model="${m}"
	if [ ! -f "ofiles/sceptic_fit_mfx_${d}_${sceptic_model}.out" ]; then
	    #matlab -nodisplay -r sceptic_fit_group_vba_ffx 2>&1 | tee ofiles/sceptic_fit_ffx_${d}_${sceptic_model}.out
	    matlab -nodisplay -r sceptic_fit_group_vba_mfx 2>&1 | tee ofiles/sceptic_fit_mfx_${d}_${sceptic_model}.out
	else
	    echo "Skipping run because sceptic_fit_mfx_${d}_${sceptic_model}.out exists."
	fi
    done
done
R CMD BATCH --no-save --no-restore compile_trial_level_dataframes.R
