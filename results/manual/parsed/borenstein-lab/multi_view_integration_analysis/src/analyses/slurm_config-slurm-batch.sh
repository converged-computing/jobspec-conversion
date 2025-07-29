#!/bin/bash
#FLUX: --job-name=misc_efrat
#FLUX: -c=8
#FLUX: --queue=cpu-elbo
#FLUX: -t=259200
#FLUX: --urgency=16

echo "SLURM DEBUG: now working on task number ${SLURM_ARRAY_TASK_ID}"
BASE_DIR=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis
cd ${BASE_DIR}
case ${SLURM_ARRAY_TASK_ID} in
  0)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_module_associations.R \
    cd_franzosa_2019 
    ;;
  1)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_module_associations.R \
    metacardis_3_8 
    ;;
  2)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_module_associations.R \
    cirrhosis_qin_2014 
    ;;
  3)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/false_discovery_analysis.R \
    cd_franzosa_2019 
    ;;
  4)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/false_discovery_analysis.R \
    metacardis_3_8 
    ;;
  5)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/false_discovery_analysis.R \
    cirrhosis_qin_2014 
    ;;
  6)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_stability_analysis.R \
    cd_franzosa_2019 
    ;;
  7)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_stability_analysis.R \
    metacardis_3_8 
    ;;
  8)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_stability_analysis.R \
    cirrhosis_qin_2014 
    ;;
  9)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_module_associations.R \
    crc_s3_s4_yachida_2019 
    ;;
  10)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/false_discovery_analysis.R \
    crc_s3_s4_yachida_2019 
    ;;
  11)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_stability_analysis.R \
    crc_s3_s4_yachida_2019 
    ;;
  12)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_module_associations.R \
    uc_franzosa_2019 
    ;;
  13)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/false_discovery_analysis.R \
    uc_franzosa_2019 
    ;;
  14)
    srun udocker run --volume=/specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis \
    efrat_ubun_r Rscript \
    /specific/elhanan/PROJECTS/MULTI_VIEW_EM/repo/multi_view_integration_analysis/src/analyses/minttea_comparisons_stability_analysis.R \
    uc_franzosa_2019 
    ;;
esac
echo "SLURM DEBUG: finished working on task number ${SLURM_ARRAY_TASK_ID}"
