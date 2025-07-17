#!/bin/bash
#FLUX: --job-name=HSP90eq
#FLUX: -c=96
#FLUX: --queue=Cascade
#FLUX: -t=61200
#FLUX: --urgency=16

code_dir=/home/ccattin/Stage/Code
gmx_code_dir=$code_dir/GMX
GMX_EXE="gmx"
run_dir=$(pwd)
input_dir=$run_dir/input
step_0_dir=$run_dir/step_0
sub_script_dir=$run_dir/script
log_dir=$run_dir/LOGS
printf "
1- Solvatation
2- Minimization
3- Equilibration
4- 25ns production
"
shopt -s extglob
echo "The job ${SLURM_JOB_ID} is running on these nodes:"
echo ${SLURM_NODELIST}
echo
cd $step_0_dir
module purge
module use /applis/PSMN/debian11/Cascade/modules/all
module load GROMACS/2021.5-foss-2021b
SCRATCH=/scratch/Cascade/ccattin/${SLURM_JOB_ID}
mkdir -p $SCRATCH
cp -r !(*.err|*.out) $SCRATCH/
cd $SCRATCH/
OUTPUTDIR=$SCRATCH/OUTPUTDIR
mkdir -p $OUTPUTDIR
prepa_dir=$SCRATCH/preparation
mkdir -p $prepa_dir
input_dir_scratch=$SCRATCH/input
cd $prepa_dir
cp $input_dir_scratch/ions.mdp .
ln -s $input_dir_scratch/processed.gro .
ln -s $input_dir_scratch/OPC4_298.15K_03.gro .
ln -s $input_dir_scratch/topol.top .
$GMX_EXE editconf -f processed.gro -o box.gro -c -d 1.3  -bt dodecahedron &> $OUTPUTDIR/editconf.out
$GMX_EXE solvate -cp box.gro -cs OPC4_298.15K_03.gro -o solv.gro -p topol.top &> $OUTPUTDIR/solvate.out
sed 's/SOL/OPC/g' topol.top > tmp  
mv tmp topol.top  
$GMX_EXE grompp -f ions.mdp -c solv.gro -p topol.top -o ions.tpr -maxwarn 2 &> $OUTPUTDIR/grompp_genion.out 
$GMX_EXE genion -s ions.tpr -o solv_ions.gro -p topol.top -pname  Na+ -nname  Cl- -neutral -conc 0.170  &>  $OUTPUTDIR/genion.out 
$GMX_EXE grompp -f ions.mdp -c solv_ions.gro -p topol.top -o solv_ions.tpr -maxwarn 2 &> $OUTPUTDIR/grompp_visu.out 
$GMX_EXE trjconv -s solv_ions.tpr -f solv_ions.gro -o solv_ions_visu.gro -pbc mol  -ur compact  &>  $OUTPUTDIR/trjconv_visualisation.out 
cd $SCRATCH
minim_dir=$SCRATCH/minimisation
mkdir -p $minim_dir
cd $minim_dir
cp $input_dir_scratch/minim.mdp .
ln -s $prepa_dir/solv_ions.gro .
ln -s $input_dir_scratch/topol.top .
$GMX_EXE grompp -f minim.mdp -c solv_ions.gro -p topol.top -o minim.tpr  -maxwarn 2 &> $OUTPUTDIR/grompp_minim.out
$GMX_EXE mdrun -v -deffnm minim -nt $SLURM_NTASKS &>$OUTPUTDIR/mdrun_minim.out 
cd $SCRATCH
equi_dir=$SCRATCH/equilibration
mkdir -p $equi_dir
nvt_dir=$equi_dir/1-NVT
mkdir -p $nvt_dir
cd $nvt_dir
cp $input_dir_scratch/nvt.mdp .
ln -s $minim_dir/minim.gro .
ln -s $input_dir_scratch/topol.top .
$GMX_EXE grompp -f nvt.mdp -c minim.gro -r minim.gro -p topol.top -o nvt.tpr  -maxwarn 2 &>$OUTPUTDIR/grompp_nvt.out  
$GMX_EXE mdrun -deffnm nvt -nt $SLURM_NTASKS &>$OUTPUTDIR/mdrun_nvt.out 
cd $SCRATCH
npt_dir=$equi_dir/2-NPT
mkdir -p $npt_dir
cd $npt_dir
cp $input_dir_scratch/npt.mdp .
ln -s $nvt_dir/nvt.gro .
ln -s $input_dir_scratch/topol.top .
$GMX_EXE grompp -f npt.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr  -maxwarn 2 &>$OUTPUTDIR/grompp_npt.out  
$GMX_EXE mdrun -deffnm npt -nt $SLURM_NTASKS &>$OUTPUTDIR/mdrun_npt.out 
cd $SCRATCH
prod_dir=$SCRATCH/production
mkdir -p $prod_dir
cd $prod_dir
cp $input_dir_scratch/prod.mdp .
ln -s $npt_dir/npt.gro .
ln -s $npt_dir/npt.cpt .
ln -s $input_dir_scratch/topol.top
$GMX_EXE grompp -f prod.mdp -c npt.gro -t npt.cpt -p topol.top -o prod.tpr -maxwarn 2 &> =$OUTPUTDIR/grompp_md_0.out
$GMX_EXE mdrun -deffnm prod -nt $SLURM_NTASKS &> $OUTPUTDIR/mdrun_md_0.out
