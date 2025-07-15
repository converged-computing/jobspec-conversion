#!/bin/bash
#FLUX: --job-name=phat-itch-8520
#FLUX: -N=2
#FLUX: -n=80
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=prod
#FLUX: -t=28800
#FLUX: --priority=16

netpyne_m1_prefix="$(pwd)/.."
module purge
spack_prefix=/gpfs/bbp.cscs.ch/project/proj16/NEURONFrontiers2021/hippocampus
module use ${spack_prefix}/spack/opt/spack/modules/tcl/linux-rhel7-x86_64
module load unstable netpyne-m-one/0.1-20211206
output_dir="${netpyne_m1_prefix}/generate_coreneuron_input/coredat_${SLURM_NTASKS}"
rm -rf ${output_dir}
working_dir_prefix="$(pwd)"
cp -r ${netpyne_m1_prefix}/M1 ${working_dir_prefix}
working_dir="${working_dir_prefix}/M1/sim"
mkdir -p "${output_dir}"
cd "${working_dir}"
sed -i "s#cfg.coreneuron = .*#cfg.dump_model = True#g" cfg.py
sed -i "s#cfg.duration = .*#cfg.duration = 1000#g" cfg.py
srun dplace special -mpi -python init.py
mv coredat $output_dir
