#!/bin/bash
#SBATCH --job-name=p-high
#SBATCH --output=err/job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00
#SBATCH --partition=sched_mit_raffaele
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=8

startt=`date +%s`
EXPNAME=$1
ITER0=$2
ITERN=$3
cd ../pgcm/ridge-0.4_del-0.2
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.4_del-0.4
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.4_del-0.8
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.4_del-inf
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.8_del-0.2
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.8_del-0.4
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.8_del-0.8
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.8_del-inf
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
echo "Waiting"
wait
endt=`date +%s`
runtime=$((endt-startt))
echo "Done Waiting at t=$runtime"
cd ../../scripts
if [ "$MAXITER" -ge "$ITERN" ]; then
	echo "Completed all model runs"
else
	# Update starting iteration
	NEWITER0=`expr $ITER0 + 1`
	# Submit the new job
	sbatch $0 $EXPNAME $NEWITER0 $ITERN
fi
