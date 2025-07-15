#!/bin/bash
#FLUX: --job-name=p-kap2
#FLUX: --exclusive
#FLUX: --queue=sched_mit_raffaele
#FLUX: -t=129600
#FLUX: --priority=16

startt=`date +%s`
EXPNAME=$1
ITER0=$2
ITERN=$3
cd ../pgcm/ridge-0.6_del-inf_kappa-0.025
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.6_del-inf_kappa-0.041
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.6_del-inf_kappa-0.066
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.6_del-inf_kappa-0.107
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.6_del-inf_kappa-0.175
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.6_del-inf_kappa-0.284
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.6_del-inf_kappa-0.461
cp ../../scripts/execute-PGCM-repeat-thread .
echo $PWD
srun -n 1 --exclusive execute-PGCM-repeat-thread $EXPNAME $ITER0 $ITERN > "output_"$ITER0".txt" &
cd ../../pgcm/ridge-0.6_del-inf_kappa-0.750
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
