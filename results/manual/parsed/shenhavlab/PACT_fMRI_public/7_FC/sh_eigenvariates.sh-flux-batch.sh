#!/bin/bash
#FLUX: --job-name=rdm-eigenvariate_pt
#FLUX: -n=4
#FLUX: -t=1800
#FLUX: --urgency=16

root_dir="/users/hritz/data/mri-data/RDM2"
spm_dir="/users/hritz/data/mri-data/analysistools/spm12"
name="perfCongBlk"      # 
fwhm=0				# 
confound="movt" 	# 
cvi="wls" 			#
declare -A labels=(\
                    [4]="8004" \
                    [5]="8005" \
                    [6]="8006" \
                    [7]="8007" \
                    [8]="8008" \
                    [9]="8009" \
                    [10]="8010" \
                    [11]="8011" \
                    [12]="8012" \
                    [13]="8013" \
                    [14]="8014" \
                    [15]="8015" \
                    [16]="8016" \
                    [17]="8017" \
                    [18]="8018" \
                    [19]="8019" \
                    [20]="8020" \
                    [21]="8021" \
                    [22]="8022" \
                    [23]="8023" \
                    [24]="8024" \
                    [25]="8025" \
                    [26]="8026" \
                    [27]="8027" \
                    [28]="8028" \
                    [29]="8029" \
                    [30]="8030" \
                    [31]="8031" \
                    [32]="8032" \
                    )
ptNum=${labels[${SLURM_ARRAY_TASK_ID}]}
module load matlab/R2019a
module load spm/spm12
echo; echo; echo; echo;
echo "========== rdm VOI =========="
echo "dir: '${root_dir}' | pt: ${ptNum} | 'name: ${name}' | fwhm: ${fwhm} | confound: '${confound}' | cvi: '${cvi}'"
echo; echo; echo; echo;
echo 'started at:'
date
echo; echo; echo; echo;
matlab-threaded –nodisplay -nodesktop -r "RDM_eigenvariates('${root_dir}','${spm_dir}', ${ptNum}, '${name}', ${fwhm}, '${confound}', '${cvi}');"
echo; echo; echo; echo;
echo 'finished at:'
date
