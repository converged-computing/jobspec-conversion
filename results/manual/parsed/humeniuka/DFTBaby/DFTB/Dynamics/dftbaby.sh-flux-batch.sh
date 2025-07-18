#!/bin/bash
#FLUX: --job-name=${2}
#FLUX: -t=8640000
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export MKL_NUM_THREADS='1 '

function usage() {
    prog=$(basename $0)
    cat <<EOF
This shell-script facilitates the preparation of a dynamics simulation.
It creates submit scripts for 
 - optimizing the initial geometry
 - running dynamics simultions
These scripts can be run interactively or can be submitted to a Torque or Slurm queue.
For each calculation a special folder structure is created.
To start a new project type
   $prog prepare
this will prompt you for a geometry file and 
prepare a new directory with the default configuration file.
Inside the new directory the following folder strucutre
will have been created:
   ./CONFIG_DEFAULT/
   ./geom.xyz
The folder ./CONFIG_DEFAULT/ contains 'dftbaby.cfg'
The individual steps of a dynamics simulation are started by the following commands:
   $prog optimize    - optimizes a molecular geometry with DFTB and computes the Hessian
   $prog sample      - samples initial conditions from the Wigner function
   $prog spectrum    - produces an absorption spectrum averaged over all initial conditions
   $prog dynamics    - select initial conditions and configuration files to prepare submit
                            scripts for a dynamics simulation
   $prog extend      - extract the last step of a previous dynamics simulation and use it
                            as the initial conditions for a subsequent dynamics simulation
   $prog vibspec     - optimizes a molecular geometry on the ground and an excited state,
                       computes the vibrational modes and frequencies on both states and
                       prepares input files for computing vibrationally resolved absorption
                       and emission spectra using Santoro's FCclasses program.
Requirements:
   - A working PBS queue system 
   - the DFTBaby programs
   - On each node the user should have read/write access to the folder
       \${SCRATCH:=scratch}/\$USER/dftbaby
EOF
    exit
}
function submit_head() {
    # Arguments: rundir jobname
    if [ "$script_type" = "jobarray" ]; then
	cat <<EOF
PBS_ARRAYID=\${PBS_ARRAYID:=\${OAR_JOBINDEX:=\${SLURM_ARRAY_TASK_ID}}}
jobname=${2}-\$(printf %.4d \${PBS_ARRAYID}) 
EOF
    else
	cat <<EOF
jobname=${2}
EOF
    fi
    cat <<EOF
source $HOME/.bashrc
rundir=${1}
tmpdir=/${SCRATCH:=scratch}/\$USER/dftbaby
rm -rf /${SCRATCH:=scratch}/\$USER/dftbaby/\$jobname
mkdir -p \$tmpdir
cp -r \$rundir/JOBS/\$jobname \$tmpdir
echo "\${HOSTNAME}:\$tmpdir/\$jobname" >> \$rundir/JOBS/job_locations.txt
function clean_up() {
   rm -fr \$rundir/RESULTS/\$jobname
   mv \$tmpdir/\$jobname \$rundir/RESULTS/
   exit
}
trap clean_up SIGHUP SIGINT SIGTERM
cd \$tmpdir/\$jobname
EOF
}
function submit_tail() {
cat <<EOF
clean_up
EOF
}
function env_body() {
cat <<EOF
module load dftbaby
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1 
EOF
}
function getname() {
    echo $(basename $(pwd))
}
function getconfdir() {
    # configuration directory
    echo "Select the directory with configuration files:"
    select confdir in $(ls -d CONFIG_*);
    do
	if [ -f $confdir/dftbaby.cfg ]
	    then 
	    echo "Configuration files taken from $confdir"
	    break
	 else
	    echo "Couldn't find 'dftbaby.cfg' in $confdir"
	    echo "Choose again:"
	fi
    done
}
function getinidir() {
    echo "Select the directory with initial conditions dynamics_####.in:"
    select inidir in $(ls -d INITIAL_*);
    do
	if [ -n "$(ls $inidir/dynamics_*.in)" ]
	    then
	    echo "Initial conditions are taken from $inidir"
	    break
	 else
	    echo "No initial conditions dynamics_####.in found in $inidir."
	    echo "Choose again:"
	fi
    done
}
function make_submit() {
    # composes the submit file by concatenating head, body and tail
    # Arguments: rundir jobname command submit-file
    local "${@}"
    submit_head $rundir $jobname > $sub
    env_body >> $sub
    echo "$commands" >> $sub
    submit_tail >> $sub
    chmod +x $sub
}
function prepare() {
    read -e -p "Path to xyz-file with molecular geometry:" xyz
    name=$(echo $(basename $xyz .xyz) | tr '[:lower:]' '[:upper:]')
    read -e -p "Name of molecule:" -i $name name
    name=$(echo $name | tr '[:lower:]' '[:upper:]')
    mkdir -p $name
    cp $xyz $name/geom.xyz
    # configurations
    configs=$name/CONFIG_DEFAULT
    mkdir -p $configs
    # copy default configuration file for DFTBaby
    module load dftbaby
    cp $(dirname $(which DFTB2.py))/dftbaby.cfg $configs/dftbaby.cfg
    echo "Please go to the directory $name to continue"
}
function optimize() {
    getconfdir # sets the variable confdir
    mkdir -p OPT/JOBS
    mkdir -p OPT/RESULTS
    # create optimization job
    jobname=$(getname)-opt
    mkdir -p OPT/JOBS/$jobname
    cp geom.xyz OPT/JOBS/$jobname
    cp $confdir/* OPT/JOBS/$jobname
    sub=OPT/JOBS/$jobname.sub
    # commands for optimizing the ground state
    commands=$(cat <<EOF
GeometryOptimization.py geom.xyz --state=0 --calc_hessian=1 --verbose=0 &> dftb.out
EOF
	    )
    # create submit script
    rundir=$(readlink -f OPT)
    make_submit
    echo "To optimize the geometry run or submit the script ./$sub"
}
function sample() {
    # check 
    optdir=OPT/RESULTS/$(getname)-opt/
    hess=$optdir/hessian.dat
    if [ ! -f $hess ] 
    then
	echo "Hessian $hess not found. You have to optimize the geometry before you can sample from the Wigner distribution."
	exit 1
    fi
    mkdir -p INITIAL_WIGNER
    read -p "Number of trajectories:" Nsample
    module load dftbaby
    initial_conditions.py $optdir/geom_opt.xyz $optdir/hessian.dat --outdir=INITIAL_WIGNER --Nsample=$Nsample
}
function dynamics() {
    # directory where the jobs should be placed
    read -e -p "Choose directory for trajectories:" -i $(pwd)/DYNAMICS dyndir
    echo "Trajectories and submit scripts will be created in $dyndir"
    # directory with initial conditions
    getinidir  # sets the variable inidir
    # configuration directory
    getconfdir # sets the variable confdir
    mkdir -p $dyndir/JOBS
    mkdir -p $dyndir/RESULTS
    # commands for dynamics
    commands=$(cat <<EOF
SurfaceHopping.py &> dynamics.out
EOF
	    )
    rundir=$(readlink -f $dyndir)
    name=$(getname)-$(basename $dyndir)
    # copy template
    for dynin in $inidir/dynamics_*.in
    do
	nr=$(echo $(basename $dynin) | sed -e "s/^.*\([0-9]\{4\}\).*/\1/g")
	# create trajectory directory
	jobname=${name}-TRAJ-$nr
	mkdir -p $dyndir/JOBS/$jobname
	# copy initial conditions, coordinates and velocities
	cp $dynin  $dyndir/JOBS/$jobname/dynamics.in
	# copy configuration files for DFTB
	cp $confdir/* $dyndir/JOBS/$jobname/
	# create submit file
	sub=$dyndir/JOBS/$jobname.sub
	make_submit
    done
    # submit script for jobarrays
    script_type="jobarray"
    sub=$dyndir/JOBS/${name}.jobarray
    jobname=${name}-TRAJ
    make_submit
    # reset script type
    script_type="individual"
    echo "To run the trajectories submit or execute the scripts in $dyndir/JOBS/*.sub"
    echo "You can also make use of jobarrays with the script $sub"
}
function extend() {
    echo "Take the geometry and velocity at the end of an old trajectory"
    echo "and use them as the initial conditions for a new trajectory"
    # directory with initial conditions
    read -e -p "Select directory with old trajectories:" -i $(pwd)/DYNAMICS olddir
    read -e -p "Choose name of directory for initial conditions:" -i INITIAL_NEW inidir
    if [ ! -d $olddir/RESULTS ]
    then
	echo "No RESULTS folder found in $olddir"
	exit
    fi
    mkdir -p $inidir
    for dynin in $olddir/RESULTS/*/dynamics.in0
    do
	nr=$(echo $(dirname $dynin) | sed -e "s/^.*\([0-9]\{4\}\).*/\1/g")
	cp $dynin $inidir/dynamics_${nr}.in
    done
    echo "Initial conditions for new trajectories were copied to $inidir"
}
function spectrum() {
    echo "Compute the TD-DFTB absorption spectrum for all initial geometries"
    getinidir  # sets the variable inidir
    read -e -p "Choose output directory for spectrum calculation:" -i SPECTRUM specdir
    getconfdir  # sets the variable confdir
    mkdir -p $specdir/JOBS
    mkdir -p $specdir/RESULTS
    # commands for computing spectrum
    commands=$(cat <<EOF
convert_xyz.py dynamics.in geom.xyz
LR_TDDFTB.py --spectrum_file=spec.dat geom.xyz &> tddftb.out
EOF
	    )
    rundir=$(readlink -f $specdir)
    for dynin in $inidir/dynamics_*.in
    do
	nr=$(echo $(basename $dynin) | sed -e "s/^.*\([0-9]\{4\}\).*/\1/g")
	# create spectrum directory
	jobname=$(getname)-SPEC-$nr
	mkdir -p $specdir/JOBS/$jobname
	# copy initial conditions, coordinates and velocities
	cp $dynin  $specdir/JOBS/$jobname/dynamics.in
	# copy configuration files for and DFTB
	cp $confdir/* $specdir/JOBS/$jobname/
	# create submit file
	sub=$specdir/JOBS/$jobname.sub
	make_submit
    done
    # submit script for jobarrays
    script_type="jobarray"
    sub=$specdir/JOBS/$(getname)-spectrum.jobarray
    jobname=$(getname)-SPEC
    make_submit
    # reset
    script_type="individual"
    echo "To compute the spectra submit or execute the scripts in $specdir/JOBS/*.sub"
    echo "You can also make use of jobarrays with the script $sub"
}
function vibspec() {
    read -e -p "Choose output directory for vibrational spectrum calculation:" -i VIBSPEC specdir
    getconfdir  # sets the variable confdir
    read -e -p "Index of excited state (>0):" -i 1 state
    mkdir -p $specdir/JOBS
    mkdir -p $specdir/RESULTS
    # create job
    name=$(echo $(getname) | tr '[:upper:]' '[:lower:]')
    jobname=$(getname)-$(basename $specdir)
    mkdir -p $specdir/JOBS/$jobname
    cp geom.xyz $specdir/JOBS/$jobname/${name}.xyz
    cp $confdir/* $specdir/JOBS/$jobname
    sub=$specdir/JOBS/$jobname.sub
    # commands
    commands=$(cat <<EOF
xyz=${name}.xyz
state=${state}
name=\$(basename \$xyz .xyz)
nat=\$(head -n 1 \$xyz)
nvib=\$(expr 3 \* \$nat - 6)
xyz0=\${name}_S0.xyz
out0=\${name}_S0.out
hess0=\${name}_S0.hess
molden0=\${name}_S0.molden
cp \$xyz \$xyz0
GeometryOptimization.py \$xyz0 --state=0 --calc_hessian=1 | tee \$out0
tail -n \$(expr \$nat + 2) \${name}_S0_opt.xyz > \$xyz0
mv hessian.dat \$hess0
mv vib.molden \$molden0
echo "optimization/frequencies for S\${state}"
xyz1=\${name}_S\${state}.xyz
out1=\${name}_S\${state}.out
hess1=\${name}_S\${state}.hess
molden1=\${name}_S\${state}.molden
cp \$xyz \$xyz1
GeometryOptimization.py \$xyz1 --state=\$state --calc_hessian=1 | tee \$out1
tail -n \$(expr \$nat + 2) \${name}_S\${state}_opt.xyz > \$xyz1
mv hessian.dat \$hess1
mv vib.molden \$molden1
LR_TDDFTB.py \$xyz0 --verbose=1 --nstates=\${state} &> \${name}_spec_at_S0.out
LR_TDDFTB.py \$xyz1 --verbose=1 --nstates=\${state} &> \${name}_spec_at_S\${state}.out
rm absorption_spectrum.dat
elec_dip=\${name}_S0-S\${state}.elec
magn_dip=\${name}_S0-S\${state}.magn
grep -A \$(expr 2 + \$state) "Excited State" \${name}_spec_at_S0.out         | tail -n 1 | sed 's/.*\\[\\(.*\\)\\].*/\\1/g' >  \${elec_dip}
grep -A \$(expr 2 + \$state) "Excited State" \${name}_spec_at_S\${state}.out  | tail -n 1 | sed 's/.*\\[\\(.*\\)\\].*/\\1/g' >> \${elec_dip}
echo "0.0 0.0 0.0" >  \${magn_dip}
echo "0.0 0.0 0.0" >> \${magn_dip}
echo "create inputs for FCclasses 2.1"
energy0=\$(grep "|grad|" \$out0 | tail -n 1 | awk '{print \$3}')
energy1=\$(grep "|grad|" \$out1 | tail -n 1 | awk '{print \$3}')
de=\$(python -c "print (\$energy1 - \$energy0)*27.211396132")
echo "total energy S0       : \$energy0 Hartree"
echo "total energy S\${state}       : \$energy1 Hartree"
echo "adiabatic excitation energy: \$de eV"
state0=\${name}_S0.state
state1=\${name}_S\${state}.state
fcclasses_input.py \$xyz0 \$hess0  \$state0
fcclasses_input.py \$xyz1 \$hess1  \$state1
inp=\${name}_abs.fcc
echo "     \$nat                        number of atoms" > \$inp
echo "     \$nvib                      number of vibrational modes" >> \$inp
cat masses.dat >> \$inp
echo "     \$de                         adiabatic energy difference in eV" >> \$inp
echo "     'abs' 'ECDNO' 'FC'           type of calculation"  >> \$inp
echo "     300.0 0.3d0                  temperature in Kelvin and Boltzmann population threshold" >> \$inp
echo "     'D' " >> \$inp
echo "     \$state0                     file input for state 1" >> \$inp
echo "     \$state1                     file input for state 2" >> \$inp
echo "     \$elec_dip                   file input for electronic transition dipoles at S0 and S1 minima" >> \$inp
echo "     \$magn_dip                   file input for magnetic transition dipoles at S0 and S1 minima" >> \$inp
echo "     0                            option for rotation 0=no 1=yes" >> \$inp
echo "     30                           max. no. of states for each mode C1 class" >> \$inp
echo "     25                           max. no. of states for each mode C2 class" >> \$inp
echo "     1.d6                         accuracy parameter" >> \$inp
echo "     'Gau' 0.5d0 12.0d0 2001 0.005d0   data for convolution Gau/Lor, ein, efin, no. points, HWHM" >> \$inp
EOF
	    )
    # create submit script
    rundir=$(readlink -f $specdir)
    make_submit
    echo "To compute vibrational spectra run or submit the script ./$sub"
}
out=dftbaby.out
case $1 in
    help)
	usage
	;;
    prepare)
	prepare     | tee -a $out
	;;
    optimize)
	optimize | tee -a $out
	;;
    sample)
	sample   | tee -a $out
	;;
    spectrum)
	spectrum | tee -a $out
	;;
    dynamics)
	dynamics | tee -a $out
	;;
    extend)
	extend   | tee -a $out
	;;
    vibspec)
	vibspec  | tee -a $out
	;;
    *)
	prog=$(basename $0)
	echo "Usage: $prog {help|prepare|optimize|sample|spectrum|dynamics|extend|vibspec}"
	exit 1
esac
