#!/bin/bash
#FLUX: --job-name=tetranucl
#FLUX: -n=2
#FLUX: --queue=sched_mit_binz,newnodes,sched_mit_hill
#FLUX: -t=43200
#FLUX: --priority=16

export pyPath='/home/xclin/bin/anaconda2/bin'
export PLUMED_USE_LEPTON='yes'

module purge
module load gcc
module load engaging/openmpi/1.8.8
export pyPath=/home/xclin/bin/anaconda2/bin
nrl=172
sim_type=restraint
to_main_dir=/nfs/pool002/users/smliu/tetra-nucl-msm/simulations-nrl-${nrl}/${sim_type}-md
echo "job uses node ${SLURMD_NODENAME}"
export PLUMED_USE_LEPTON=yes
lammpsdir="/home/xclin/bin/awsem/bin"
curr=0 
max_id=0 
prev=$(($curr - 1))
next=$(($curr + 1))
curr=$(printf "%'03d" ${curr}) 
prev=$(printf "%'03d" ${prev})
cd run${curr} # run the following commands in run${curr}
sed "s/RANDOMSEED/$RANDOM/g" ../../template_template.lammps > ../../template.lammps 
$pyPath/python  ../../get_lammps_input.py ../run${prev} ./ ${curr}
mpirun -np 2 $lammpsdir/lmp_openmpi_plumed246_3spn_2016_sbm_rigidtemper_tanh -partition 1x2 -in proteinDna_sim.in
cd ../
echo "simulation finished"
if [ "${next}" -le "${max_id}" ]
then
    sbatch myjob_eofe-${next}.slurm
fi
echo "job done"
