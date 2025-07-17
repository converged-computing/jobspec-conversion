#!/bin/bash
#FLUX: --job-name=loopy-chair-6130
#FLUX: --urgency=16

export HSA_IGNORE_SRAMECC_MISREPORT='1'
export PE_MPICH_GTL_DIR_amd_gfx90a='-L${CRAY_MPICH_ROOTDIR}/gtl/lib'
export PE_MPICH_GTL_LIBS_amd_gfx90a='-lmpi_gtl_hsa'

let nnds=1
let appto=500
./processcp.pl ${nnds}
./plopper.pl plopper.py ${appto}
cat >batch.job <<EOF
source /ccs/home/wuxf/anaconda3/etc/profile.d/conda.sh
module load PrgEnv-amd/8.3.3
module load cray-hdf5/1.12.0.7
module load cmake
module load craype-accel-amd-gfx90a
module load rocm/4.5.2
module load cray-mpich/8.1.14
export HSA_IGNORE_SRAMECC_MISREPORT=1
export PE_MPICH_GTL_DIR_amd_gfx90a="-L${CRAY_MPICH_ROOTDIR}/gtl/lib"
export PE_MPICH_GTL_LIBS_amd_gfx90a="-lmpi_gtl_hsa"
conda activate ytune
python -m ytopt.search.ambs --evaluator ray --problem problem.Problem --max-evals=128 --learner RF
conda deactivate
EOF
chmod +x batch.job
sbatch batch.job
