#!/bin/bash
#FLUX: --job-name=corrected-slab
#FLUX: --queue=shared
#FLUX: -t=36000
#FLUX: --urgency=16

prefix=corrected-slab
rtemp=298
press=1
curr_dir=$SLURM_SUBMIT_DIR
temp_dir=/expanse/lustre/scratch/$USER/temp_project/md/lammps/${prefix}/${rtemp}K
lmp_equil_file=in.${prefix}
lmp_data_file=data.${prefix}
module purge
module load cpu slurm gcc openmpi cmake gsl intel-mkl
PARALLEL="srun --mpi=pmi2"
LMP="/home/tpascal/codes/bin/lmp_expanse -screen none -var rtemp $rtemp -var press $press"
mkdir -p $temp_dir/analysis ${curr_dir}/results
cd $temp_dir
for i in $lmp_data_file $lmp_equil_file 
do
	cp ${curr_dir}/${i} ./
done
echo "LAMMPS dynamics of ${prefix} at ${rtemp}K"
echo "running in $temp_dir"
$PARALLEL $LMP -in ${lmp_equil_file} -log ${prefix}.${rtemp}K.equil.lammps.log
cp *.equil.lammps.log *.prod.lammps ${curr_dir}/results
