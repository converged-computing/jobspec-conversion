#!/bin/bash
#FLUX: --job-name=larmaedata
#FLUX: --queue=batch
#FLUX: -t=28800
#FLUX: --urgency=16

container=/cluster/tufts/wongjiradlabnu/larbys/larbys-container/singularity_minkowskiengine_u20.04.cu111.torch1.9.0_comput8.sif
DATA_PREP_DIR=/cluster/tufts/wongjiradlabnu/twongj01/larmae/dataprep/
module load singularity/3.5.3
cd /cluster/tufts/
srun singularity exec ${container} bash -c "cd ${DATA_PREP_DIR} && source run_make_mlrecodata_mcc9_v13_bnb_nu_corsika.sh"
