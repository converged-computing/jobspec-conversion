#!/bin/bash
#FLUX: --job-name=2_deeplab_AR_detect
#FLUX: -N=1484
#FLUX: --queue=regular
#FLUX: -t=2700
#FLUX: --urgency=16

module swap PrgEnv-intel PrgEnv-gnu
module use /global/common/software/m1517/teca/cori/develop/modulefiles
module load teca
set -e
set -x
pytorch_model=/global/cscratch1/sd/loring/teca_testing/TECA_data/cascade_deeplab_IVT.pt
out_dir=HighResMIP_ECMWF_ECMWF-IFS-HR_highresSST-present_r1i1p1f1_6hrPlevPt/deeplab_all
rm -rf ${out_dir}
mkdir -p ${out_dir}
time srun -N 1484 -n 23741 teca_deeplab_ar_detect \
    --pytorch_model ${pytorch_model} \
    --input_file ./HighResMIP_ECMWF_ECMWF-IFS-HR_highresSST-present_r1i1p1f1_6hrPlevPt.mcf \
    --compute_ivt --wind_u ua --wind_v va --specific_humidity hus \
    --write_ivt --write_ivt_magnitude \
    --output_file ${out_dir}/deeplab_AR_%t%.nc \
    --steps_per_file 128
