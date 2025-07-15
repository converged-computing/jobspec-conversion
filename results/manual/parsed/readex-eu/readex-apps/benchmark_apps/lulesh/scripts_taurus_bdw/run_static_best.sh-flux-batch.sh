#!/bin/bash
#FLUX: --job-name=buttery-banana-8092
#FLUX: -c=28
#FLUX: --exclusive
#FLUX: --queue=broadwell
#FLUX: -t=14400
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/sw/global/libraries/cpufrequtils/gcc5.3.0/lib/'

cd ..
REPEAT_COUNT=3
module purge
source ./readex_env/set_env_saf.source
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/sw/global/libraries/cpufrequtils/gcc5.3.0/lib/
NUM_CPUS=28
change_frequency() {
for ((i = 0; i<$NUM_CPUS; i++))
do 
	/sw/global/libraries/cpufrequtils/gcc5.3.0/bin/cpufreq-set -c $i -f $1GHz
done
}
check_uncore_frequency() {
	x86a_read -n -i Intel_UNCORE_MIN_RATIO
   	x86a_read -n -i Intel_UNCORE_MAX_RATIO
    x86a_read -n -i Intel_UNCORE_CURRENT_RATIO
}
i=1
rm -rf PLAIN_*
while [ $i -le $REPEAT_COUNT ]; do
  mkdir PLAIN_$i
  export MEASURE_RAPL_TARGET="PLAIN_$i"
  #srun --cpu_bind=verbose,sockets measure-rapl ./test/amg2013_plain -P 2 2 2 -r 40 40 40
  #srun --ntasks 8 --ntasks-per-node 1 --cpus-per-task 24 ./lulesh2.0_plain -i 500 -s 75
  srun measure-rapl ./lulesh2.0_plain -i 100 -s 150 
 i=$(echo "$i + 1" | bc)
done
		#export MEASURE_RAPL_TARGET="TUNED_$sum"
		#srun measure-rapl ./lulesh2.0_plain -i 250 -s 75
		#srun -n 1 -c 24 --exclusive --mem-per-cpu 2500M -p haswell --reservation=READEX ./lulesh2.0_plain -i 50 -s 75 
		#sum=$sum + 1
		#((sum++))
		#echo $sum
i=1
total_time_plain=0
total_energy_plain=0
total_cpu_energy_plain=0
while [ $i -lt $REPEAT_COUNT ]; do
  times_energys=$(sacct -j $SLURM_JOBID.$i --format="JobID,CPUTimeRAW,ConsumedEnergyRaw")
  i=$(echo "$i + 1" | bc)
  times_energys_array=(${times_energys[@]})
  time_step=${times_energys_array[7]}
  energy_step=${times_energys_array[8]}
  echo "Job Time: $time_step"
  echo "Job Energy: $energy_step"
  total_time_plain=$(echo "${total_time_plain} + ${time_step}" | bc)
  total_energy_plain=$(echo "${total_energy_plain} + ${energy_step}" | bc)
  for file in PLAIN_$i/*
  do
    values=$( tail -1 $file | awk -F'[ ,]' '{print int($1)" "int($2)}' )
    values=(${values[@]})
    total_cpu_energy_plain=$[ total_cpu_energy_plain + ${values[0]} + ${values[1]} ]
  done
done
  #total_time_rrl=$(echo "${total_time_rrl} + ${time_step}" | bc)
  #total_energy_rrl=$(echo "${total_energy_rrl} + ${energy_step}" | bc)
  #for file in TUNED_$i/*
  #do
   # values=$( tail -1 $file | awk -F'[ ,]' '{print int($1)" "int($2)}' )
    #values=(${values[@]})
    #total_cpu_energy_rrl=$[ total_cpu_energy_rrl + ${values[0]} + ${values[1]} ]
    #total_cpu_energy_rrl=${values[0]} + ${values[1]}
	#echo "Total Cpu Energy for one configuration : ${total_cpu_energy_rrl}"
  #done
echo "Total Plain Time = $total_time_plain, Total Plain Energy = $total_energy_plain"
avg_time_plain=$(echo "$total_time_plain/$((REPEAT_COUNT-1))" | bc)
avg_energy_plain=$(echo "$total_energy_plain/$((REPEAT_COUNT-1))" | bc)
echo "Average Plain Time=$avg_time_plain"
echo "Average Plain Energy=$avg_energy_plain"
rm -rf PLAIN_*
