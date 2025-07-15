#!/bin/bash
#FLUX: --job-name="HtrA1"
#FLUX: --queue=mf_nes2.8
#FLUX: -t=43200
#FLUX: --priority=16

copy_local="yes"
nprocs=$SLURM_NTASKS
nnodes=$SLURM_JOB_NUM_NODES
slurm_startjob(){
bash add_ions_loop_3.sh
echo Job Done
}
slurm_info_out(){
echo "=================================== SLURM JOB ==================================="
date
echo
echo "The job will be started on the following node(s):"
echo $SLURM_JOB_NODELIST
echo
echo "Slurm User:         $SLURM_JOB_USER"
echo "Run Directory:      $(pwd)"
echo "Job ID:             $SLURM_JOB_ID"
echo "Job Name:           $SLURM_JOB_NAME"
echo "Partition:          $SLURM_JOB_PARTITION"
echo "Number of nodes:    $SLURM_JOB_NUM_NODES"
echo "Number of tasks:    $SLURM_NTASKS"
echo "Submitted From:     $SLURM_SUBMIT_HOST:$SLURM_SUBMIT_DIR"
echo "=================================== SLURM JOB ==================================="
echo
echo "--- SLURM job-script output ---"
}
if [ "$copy_local" = "yes" ]; then
  echo $HOSTNAME > $SLURM_SUBMIT_DIR/SLURM_WORK_NODE-$SLURM_JOB_ID
  if [ "$?" -ne "0" ]; then
    echo "Unable to write $SLURM_SUBMIT_DIR/SLURM_WORK_NODE-$SLURM_JOB_ID"
    echo "$SLURM_JOB_ID on node $HOSTNAME failed to write $SLURM_SUBMIT_DIR/SLURM_WORK_NODE-$SLURM_JOB_ID " >> $HOME/SURM_WARNINGS
    echo "$SLURM_SUBMIT_DIR/SLURM_WORK_NODE-$SLURM_JOB_ID should contain:" >> $HOME/SLURM_WARNINGS
    echo "$HOSTNAME" >> $HOME/SLURM_WARNINGS
  fi
  if (( $SLURM_JOB_NUM_NODES > 1 )); then
    work_dir="/work/cluster/$USER/$SLURM_JOB_ID"
  else
    work_dir="/work/$USER/$SLURM_JOB_ID"
  fi
  mkdir -p $work_dir
  rsync -a --exclude=slurm-${SLURM_JOB_ID}.* $SLURM_SUBMIT_DIR/ $work_dir/
  if (( $? != 0)); then
    echo "FAIL: rsync to local execution directory had problems. Aborting job."
    exit 1
  else
    echo "$work_dir" > $SLURM_SUBMIT_DIR/SLURM_WORK_DIR-$SLURM_JOB_ID
    if [ "$?" -ne "0" ]; then
      echo "Unable to write $SLURM_SUBMIT_DIR/SLURM_WORK_DIR-$SLURM_JOB_ID"
      echo "$SLURM_JOB_ID on node $HOSTNAME failed to write $SLURM_SUBMIT_DIR/SLURM_WORK_DIR-$SLURM_JOB_ID" >> $HOME/SLURM_WARNINGS
      echo "$SLURM_SUBMIT_DIR/SLURM_WORK_DIR-$SLURM_JOB_ID should contain:" >> $HOME/SLURM_WARNINGS
      echo "$work_dir" >> $HOME/SLURM_WARNINGS
    fi
  fi
  cd $work_dir
fi
slurm_info_out
slurm_startjob
if [ "$copy_local" = "yes" ]; then
  rsync -a $work_dir/ $SLURM_SUBMIT_DIR/
  if (( $? == 0)); then
    cd $SLURM_SUBMIT_DIR
    rm -rf $work_dir
    # Since the copyback worked, delete the file that triggers the post-execution script
    rm $SLURM_SUBMIT_DIR/SLURM_WORK_DIR-$SLURM_JOB_ID
    rm $SLURM_SUBMIT_DIR/SLURM_WORK_NODE-$SLURM_JOB_ID
  else
    echo "FAIL: rsync back to submission directory had problems. Execution directory not removed."
    echo "$SLURM_JOB_ID on node $HOSTNAME had problems on final rsync" >> $HOME/SLURM_WARNINGS
    cd $SLURM_SUBMIT_DIR
    exit 1
  fi
fi
