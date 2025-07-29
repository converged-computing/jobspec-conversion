#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=4-00:12:00
#SBATCH --partition=main
#SBATCH --constraint=ntasks-per-node=1

export MAXJOBSN='24  # must equal value of "--cpus-per-task'

export MAXJOBSN=24  # must equal value of "--cpus-per-task"
if [ $# -ne 1 ] || [ ! -f $1 ]; then
	echo "[ERROR] Must invoke through \"enqueue_job.sh\"";
	exit 1;
fi
set +e;
module load gcc;
module load bison;
CWD=$PWD;
cd `dirname $1`;
srun -o %j.out -e %j.err /bin/bash `basename $1`;
cd $CWD;
exit 0;
