#!/bin/bash
#FLUX: --job-name=plotV1
#FLUX: -c=3
#FLUX: -t=3600
#FLUX: --urgency=16

set -e
module purge
module load gcc/10.2.0
module load cuda/11.1.74
module load boost/intel/1.74.0
module load matlab/2020b
module load python/intel/3.8.6
module list
cd ${data_fdr}
patch_cfg=${fig_fdr}/${trial_suffix}-ori_${ori}.cfg
date
echo ${patch} -c $patch_cfg
${patch} -c $patch_cfg
date
usePrefData=False
collectMeanDataOnly=False
if [ "$fitTC" = True ]; then
	OPstatus=0
else
	OPstatus=1
fi
pid=""
echo python ${fig_fdr}/plotLGN_response_${trial_suffix}.py ${trial_suffix}_${ori} ${LGN_V1_suffix} ${data_fdr} ${fig_fdr}
python ${fig_fdr}/plotLGN_response_${trial_suffix}.py ${trial_suffix}_${ori} ${LGN_V1_suffix} ${data_fdr} ${fig_fdr} &
pid+="${!} "
echo python ${fig_fdr}/plotV1_response_${trial_suffix}.py ${trial_suffix} ${res_suffix} ${LGN_V1_suffix} ${V1_connectome_suffix} ${res_fdr} ${data_fdr} ${fig_fdr} ${TF} ${ori} ${nOri} ${readNewSpike} ${usePrefData} ${collectMeanDataOnly} ${OPstatus}
python ${fig_fdr}/plotV1_response_${trial_suffix}.py ${trial_suffix} ${res_suffix} ${LGN_V1_suffix} ${V1_connectome_suffix} ${res_fdr} ${data_fdr} ${fig_fdr} ${TF} ${ori} ${nOri} ${readNewSpike} ${usePrefData} ${collectMeanDataOnly} ${OPstatus} &
pid+="${!} "
if [ "${singleOri}" = True ]; then
	if [ "${generate_V1_connection}" = True ]; then
		echo python ${fig_fdr}/connections_${V1_connectome_suffix}.py ${trial_suffix}_${ori} ${res_suffix} ${LGN_V1_suffix} ${V1_connectome_suffix} ${res_fdr} ${data_fdr} ${fig_fdr}
		python ${fig_fdr}/connections_${V1_connectome_suffix}.py ${trial_suffix}_${ori} ${res_suffix} ${LGN_V1_suffix} ${V1_connectome_suffix} ${res_fdr} ${data_fdr} ${fig_fdr}
		pid+="${!} "
	fi
fi
wait $pid
date
