#!/bin/bash
#FLUX: --job-name=sel_func_G20.5_zsplit2
#FLUX: -c=4
#FLUX: -t=64800
#FLUX: --priority=16

n_zbins=2
tag_cat_extra=""
echo "'My SLURM_ARRAY_TASK_ID:' $SLURM_ARRAY_TASK_ID"
echo "'Running selfunc for' ../data/quaia_G20.5_zsplit${n_zbins}bin${SLURM_ARRAY_TASK_ID}${tag_cat_extra}.fits"
echo "'Saving selfunc to' ../data/maps/selection_function_NSIDE64_G20.5_zsplit${n_zbins}bin${SLURM_ARRAY_TASK_ID}${tag_cat_extra}.fits"
echo "Starting batch job"
cd ~
overlay_ext3=/scratch/ksf293/overlay-50G-10M.ext3
singularity \
exec --overlay $overlay_ext3:ro \
/scratch/work/public/singularity/centos-7.8.2003.sif /bin/bash \
-c "source /ext3/env.sh; \
/bin/bash; \
cd /home/ksf293/gaia-quasars-lss/code; \
conda activate gaiaenv; \
python selection_function_map.py ../data/quaia_G20.5_zsplit${n_zbins}bin${SLURM_ARRAY_TASK_ID}${tag_cat_extra}.fits ../data/maps/selection_function_NSIDE64_G20.5_zsplit${n_zbins}bin${SLURM_ARRAY_TASK_ID}${tag_cat_extra}.fits ../data/quaia_G20.5.fits;
"
