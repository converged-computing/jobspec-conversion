#!/bin/bash
#FLUX: --job-name=HSP90_1
#FLUX: -c=96
#FLUX: --queue=Cascade
#FLUX: -t=144000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

code_dir=/home/ccattin/Stage/Code
gmx_code_dir=$code_dir/GMX
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
GMX_EXE="gmx"
run_dir=$(pwd)
step_0_dir=$run_dir/step_0
step_1_dir=$run_dir/step_1
input_dir=$step_1_dir/input
input_global_dir=$run_dir/input
sub_script_dir=$run_dir/script
log_dir=$run_dir/LOGS
printf "
1st Production step : 100 ns
"
shopt -s extglob
echo "The job ${SLURM_JOB_ID} is running on these nodes:"
echo ${SLURM_NODELIST}
echo
cd $step_1_dir
module purge
module use /applis/PSMN/debian11/Cascade/modules/all
module load GROMACS/2021.5-foss-2021b
SCRATCH=/scratch/Cascade/ccattin/${SLURM_JOB_ID}
mkdir -p $SCRATCH
cp -r !(*.err|*.out) $SCRATCH/
cd $SCRATCH/
OUTPUTDIR=$SCRATCH/OUTPUTDIR
mkdir -p $OUTPUTDIR
mkdir -p $SCRATCH/production
cd $SCRATCH/production
cp $input_dir/prod.mdp .
ln -s $step_0_dir/production/prod.gro prev.gro
ln -s $step_0_dir/production/prod.cpt prev.cpt
ln -s $input_dir/topol.top .
ln -s $input_dir/index.ndx .
echo "        Running gmx grompp"
$GMX_EXE grompp -f prod.mdp -c prev.gro -t prev.cpt -p topol.top -o prod.tpr -n index.ndx &> $OUTPUTDIR/grompp_prod.out
echo "    Running gmx mdrun"
$GMX_EXE mdrun -deffnm prod -nt $SLURM_CPUS_PER_TASK &> $OUTPUTDIR/mdrun.out
echo "        Production run done."
cp -r $SCRATCH/* $step_1_dir
cd $run_dir
rm -r $SCRATCH
step_2_dir=$run_dir/step_2
mkdir -p $step_2_dir
cp -r $input_global_dir/step_1 $step_2_dir/input
mv *.err $log_dir
mv *.out $log_dir
sbatch $sub_script_dir/submit_2
