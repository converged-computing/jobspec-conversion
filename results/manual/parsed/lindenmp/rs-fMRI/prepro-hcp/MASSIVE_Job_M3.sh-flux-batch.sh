#!/bin/bash
#FLUX: --job-name=fMRI-HCP-PrePro
#FLUX: -t=18000
#FLUX: --priority=16

SUBJECT_LIST="/home/lindenmp/kg98/Linden/ResProjects/HCP_BF_TimeSeries/HCP_100.txt"
module load rest/1.8 # works on M2 and M3
module load fsl/5.0.9 # works on M2 and M3. FSLDIR is different though.
module load python/2.7.11-gcc # works on M2 and M3.
module load ants/1.9.v4 # works on M2 and M3
module load afni/16.2.16
module load spm8/matlab2015b.r6685 # M3
subject=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${SUBJECT_LIST})
echo -e "\t\t\t --------------------------- "
echo -e "\t\t\t ----- ${SLURM_ARRAY_TASK_ID} ${subject} ----- "
echo -e "\t\t\t --------------------------- \n"
cd /home/lindenmp/kg98/Linden/Scripts/rs-fMRI/prepro-hcp/
matlab -nodisplay -r "HCP_run_prepro('${subject}'); exit"
