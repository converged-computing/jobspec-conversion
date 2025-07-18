#!/bin/bash
#FLUX: --job-name=frigid-spoon-1940
#FLUX: --urgency=16

if [ $# -lt 9 ]; then
  echo "Usage: $0 <first> <last> <beta> <MH> <start> nsteps:{<outer> <inner> <gauge>} <time> [dependency (optional)]"
  exit 1
fi
first=$1
last=$2
beta=$3
MH=$4
start=$5
outer=$6
inner=$7
gauge=$8
time=$9
node=26
cpus=512
Nf=12
L=48
mass=0.0
ratio=-0.25
traj_length=1.0
Ntraj=10
tag=b${beta}
echo "#!/bin/sh" > temp
echo "#SBATCH --nodes=$node" >> temp
echo "#SBATCH --ntasks-per-node=20" >> temp
echo "#SBATCH --mem-per-cpu=1G" >> temp
echo "#SBATCH --time=$time" >> temp
echo "#SBATCH --partition all" >> temp
echo "#SBATCH --exclusive" >> temp
echo "#SBATCH --job-name HMC${L}_$tag" >> temp
echo "#SBATCH --output hmc.%j.out" >> temp
echo "#SBATCH --error hmc.%j.err" >> temp
echo "#SBATCH --mail-user=daschaich@gmail.com" >> temp
echo "#SBATCH --mail-type=all" >> temp
if [ $# -gt 9 ]; then
  echo "#SBATCH -d afterok:${10}" >> temp
fi
dir=/home/ubelix/itp/schaich/KS_nHYP_FA/Run_APBC${Nf}_${L}$L
bin=/home/ubelix/itp/schaich/bins/su3_hmc_APBC
cd $dir
echo "cd $dir" >> temp
module load impi/2018.1.163-iccifort-2018.1.163-GCC-6.4.0-2.28
lat=$dir/Configs/gauge_${L}${L}_${beta}_${ratio}_${mass}_$start.$first
if [ ! -f $lat ]; then
  echo "WARNING: LATTICE $lat NOT FOUND"
  # Allow job to be submitted with warning,
  # so it can accumulate priority while the starting config is generated
fi
for(( i=$first ; $i<=$last ; i++ )); do
  out=$dir/Out/out_${start}_${L}${L}_${beta}_${ratio}_$mass.$i
  lat=$dir/Configs/gauge_${L}${L}_${beta}_${ratio}_${mass}_$start.$[$i+1]
  if [ -f $out ]; then
    echo "ERROR: OUTPUT FILE $out EXISTS, SUBMISSION ABORTED"
    rm -f temp
    exit 1
  fi
  if [ -f $lat ]; then
    echo "ERROR: LATTICE $lat EXISTS, SUBMISSION ABORTED"
    rm -f temp
    exit 1
  fi
done
iter=0
for(( i=$first ; $i<=$last ; i++ )); do
  next=$[$i + 1]
  iter=$[$iter + 1]
  out=$dir/Out/out_${start}_${L}${L}_${beta}_${ratio}_$mass.$i
  lat=$dir/Configs/gauge_${L}${L}_${beta}_${ratio}_${mass}_$start
  echo "echo \"Job \$SLURM_JOB_NAME started \"\`date\`\" jobid \$SLURM_JOB_ID\" >> $out" >> temp
  echo "echo \"=== Running MPI application on $cpus cpus ===\" >> $out" >> temp
  echo "echo \"mpirun -np $cpus $bin\" >> $out" >> temp
  echo "mpirun -np $cpus $bin << EOF >> $out" >> temp
  echo "prompt 0" >> temp
  echo "nflavors $Nf" >> temp
  echo "nx $L" >> temp
  echo "ny $L" >> temp
  echo "nz $L" >> temp
  echo "nt $L" >> temp
  echo "iseed ${last}${beta/\./41}${L}$i" >> temp
  echo "warms 0" >> temp
  echo "trajecs $Ntraj" >> temp
  echo "traj_length $traj_length" >> temp
  echo "number_of_PF 2" >> temp
  echo "nstep $outer" >> temp
  echo "nstep $inner" >> temp
  echo "nstep_gauge $gauge" >> temp
  echo "traj_between_meas $Ntraj" >> temp
  echo "beta $beta" >> temp
  echo "beta_a $ratio" >> temp
  echo "mass $mass" >> temp
  echo "Hasenbusch_mass $MH" >> temp
  echo "Nsmear 1" >> temp
  echo "alpha_hyp0 0.5" >> temp
  echo "alpha_hyp1 0.5" >> temp
  echo "alpha_hyp2 0.4" >> temp
  echo "npbp 3" >> temp
  echo "max_cg_iterations 7500" >> temp
  echo "max_cg_restarts 1" >> temp
  echo "error_per_site 1e-7" >> temp
  echo "reload_serial $lat.$i" >> temp
  echo "save_serial $lat.$next" >> temp
  echo "EOF" >> temp
  echo "echo \"=== MPI application finished at \"\`date\`\" ===\" >> $out" >> temp
  # Extract order parameter building blocks at runtime
  Sout=$dir/Out/Sout_${start}_${L}${L}_${beta}_${ratio}_$mass.$next
  echo "/lqcdproj/nHYPBSM/extract_params $out $Sout" >> temp
  echo "chmod 664 $out $Sout $lat.$i* $lat.$next*" >> temp
  echo "" >> temp
done
sbatch temp
echo "Requested $time to run $iter jobs"
echo -ne "  The latest file in this ensemble is "
ls -tr Out/out_${start}_${L}${L}_${beta}_${ratio}_$mass.* | tail -n 1
echo     "The first file this job will write is Out/out_${start}_${L}${L}_${beta}_${ratio}_$mass.$first"
echo "Cancel the job if this doesn't look right"
rm -f temp
