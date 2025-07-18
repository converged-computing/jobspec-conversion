#!/bin/bash
#FLUX: --job-name=h2o_6
#FLUX: -n=16
#FLUX: --queue=devtaras
#FLUX: --urgency=16

source ~/venv_python3/bin/activate
d=/auto/tms7/herzog1/build/qp2/bin
source $d/../quantum_package.rc
  cd $SLURM_SUBMIT_DIR
  ulimit -s unlimited
  export OMP_NUM_THREADS=16
  echo '---- Began at ----'
  date
  echo ''
  echo '---- Cluster/Job Info ----'
  echo "    Job ID                     $SLURM_JOB_ID"
  echo "    Job Name                   $SLURM_JOB_NAME"
  echo "    Submit Directory           $SLURM_SUBMIT_DIR"
  echo "    Temporary Directory        $TMPDIR" 
  echo "    Host submitted from        $SLURM_SUBMIT_HOST"
  echo "    Number of nodes allocated  $SLURM_JOB_NUM_NODES"
  echo "    Number of cores/node       $SLURM_CPUS_ON_NODE"
  echo "    Total number of cores      $SLURM_NTASKS"
  echo "    Nodes assigned to job      $SLURM_JOB_NODELIST"
  echo ''
bindir=/auto/tms7/herzog1/opt/CIgen/src
sys=h2o.ezfio
N=26
Ne=10
tol=12
Ns=50000
re_start=0
eout=en.out
dout=ndets.out
qp_log=qp.out
set -xe
if [ $re_start = 0 ]
then 
qp_reset $sys
qp_run scf $sys > scf.out
qp_run cisd $sys > cisd.out
echo "#" >> $eout
grep "Energy of state" cisd.out | tail -n 1 | awk '{print $6}' >> $eout
qp_run ml_ci_write $sys 
$bindir/qp2cigen.py $N $Ne $tol $Ns
cp dets dets_cisd
else
  echo "# restart" >> $eout
  qp_run ml_ci_read $sys #read new wf
  qp_run diagonalize_h $sys >> $qp_log
  grep "Energy of state" $qp_log | tail -n 1 | awk '{print $6}' >>  $eout
  qp_run ml_ci_write $sys
  $bindir/qp2cigen.py $N $Ne $tol $Ns
fi
for i in {1..20}
do
  echo ' '
  echo ' '
  echo 'Procedure iteration :  ' $i
  time $bindir/CI_gen 
  cp dets dets_rbm
  nd=$(wc -l < dets)
  echo 'ndets = ' $nd
  echo $nd >> $dout
  $bindir/cigen2qp.py $N $Ne
  qp_run ml_ci_read $sys #read new wf
  qp_run diagonalize_h $sys >> $qp_log
  grep "Energy of state" $qp_log | tail -n 1 | awk '{print $6}' >>  $eout
  qp_run ml_ci_write $sys
  $bindir/qp2cigen.py $N $Ne $tol $Ns
done
  echo ""
  echo '---- Finished at ----'
  date
  echo ''
