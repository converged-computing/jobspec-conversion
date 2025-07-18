#!/bin/bash
#FLUX: --job-name=lulesh_sacct
#FLUX: -c=28
#FLUX: --exclusive
#FLUX: --queue=broadwell
#FLUX: -t=7200
#FLUX: --urgency=16

export MERIC_MODE='3'
export MERIC_DEBUG='0'
export MERIC_CONTINUAL='1'
export MERIC_AGGREGATE='0'
export MERIC_DETAILED='0'
export MERIC_NUM_THREADS='0'
export MERIC_FREQUENCY='0'
export MERIC_UNCORE_FREQUENCY='0'
export MERIC_REGION_OPTIONS='./energy.opts'

cd ..
REPEAT_COUNT=5
module purge
source ./readex_env/set_env_plain.source
i=1
rm -rf PLAIN_*
while [ $i -le $REPEAT_COUNT ]; do
  mkdir PLAIN_$i
  export MEASURE_RAPL_TARGET="PLAIN_$i"
  #srun measure-rapl ./test/amg2013_plain -P 2 2 2 -r 40 40 40
  srun measure-rapl ./lulesh2.0_plain -i 100 -s 150
  #srun ./lulesh2.0_plain -i 250 -s 75 
  i=$(echo "$i + 1" | bc)
done
module purge
source ./readex_env/set_env_meric.source
export MERIC_MODE=3
export MERIC_DEBUG=0
export MERIC_CONTINUAL=1
export MERIC_AGGREGATE=0
export MERIC_DETAILED=0
export MERIC_NUM_THREADS=0
export MERIC_FREQUENCY=0
export MERIC_UNCORE_FREQUENCY=0
export MERIC_REGION_OPTIONS=./energy.opts
i=1
rm -rf TUNED_*
while [ $i -le $REPEAT_COUNT ]; do
  mkdir TUNED_$i
  export MEASURE_RAPL_TARGET="TUNED_$i"
  #srun --cpu_bind=verbose,sockets measure-rapl ./test/amg2013_meric -P 2 2 2 -r 40 40 40
  #srun measure-rapl ./lulesh2.0_meric -i 250 -s 75 
  srun measure-rapl ./lulesh2.0_meric -i 100 -s 150 
  i=$(echo "$i + 1" | bc)
done
i=1
total_time_plain=0
total_energy_plain=0
total_cpu_energy_plain=0
while [ $i -lt $REPEAT_COUNT ]; do
  echo "command: sacct -j $SLURM_JOBID.$i --format="JobID,CPUTimeRAW,ConsumedEnergyRaw""
  times_energys=$(sacct -j $SLURM_JOBID.$i --format="JobID,CPUTimeRAW,ConsumedEnergyRaw")
  i=$(echo "$i + 1" | bc)
  times_energys_array=(${times_energys[@]})
  time_step=${times_energys_array[7]}
  energy_step=${times_energys_array[8]}
  total_time_plain=$(echo "${total_time_plain} + ${time_step}" | bc)
  total_energy_plain=$(echo "${total_energy_plain} + ${energy_step}" | bc)
  for file in PLAIN_$i/*
  do
    values=$( tail -1 $file | awk -F'[ ,]' '{print int($1)" "int($2)}' )
    values=(${values[@]})
    total_cpu_energy_plain=$[ total_cpu_energy_plain + ${values[0]} + ${values[1]} ]
  done
done
i=1
total_time_rrl=0
total_energy_rrl=0
total_cpu_energy_rrl=0
while [ $i -lt $REPEAT_COUNT ]; do
  echo "command: sacct -j $SLURM_JOBID.$((i+REPEAT_COUNT)) --format="JobID,CPUTimeRAW,ConsumedEnergyRaw""	
  times_energys=$(sacct -j $SLURM_JOBID.$((i+REPEAT_COUNT)) --format="JobID,CPUTimeRAW,ConsumedEnergyRaw")
  i=$(echo "$i + 1" | bc)
  times_energys_array=(${times_energys[@]})
  time_step=${times_energys_array[7]}
  energy_step=${times_energys_array[8]}
  total_time_rrl=$(echo "${total_time_rrl} + ${time_step}" | bc)
  total_energy_rrl=$(echo "${total_energy_rrl} + ${energy_step}" | bc)
  for file in TUNED_$i/*
  do
    values=$( tail -1 $file | awk -F'[ ,]' '{print int($1)" "int($2)}' )
    values=(${values[@]})
    total_cpu_energy_rrl=$[ total_cpu_energy_rrl + ${values[0]} + ${values[1]} ]
  done
done
echo "Total Plain Time = $total_time_plain, Total Plain Energy = $total_energy_plain"
echo "Total MERIC Time = $total_time_rrl, Total MERIC Energy = $total_energy_rrl"
avg_time_plain=$(echo "$total_time_plain / $((REPEAT_COUNT-1))" | bc)
avg_energy_plain=$(echo "$total_energy_plain / $((REPEAT_COUNT-1))" | bc)
avg_time_rrl=$(echo "$total_time_rrl / $((REPEAT_COUNT-1))" | bc)
avg_energy_rrl=$(echo "$total_energy_rrl / $((REPEAT_COUNT-1))" | bc)
avg_cpu_energy_plain=$(echo "$total_cpu_energy_plain / $((REPEAT_COUNT-1))" | bc)
avg_cpu_energy_rrl=$(echo "$total_cpu_energy_rrl / $((REPEAT_COUNT-1))" | bc)
echo "Average Plain Time = $avg_time_plain, Average MERIC Time = $avg_time_rrl"
echo "Average Plain Energy = $avg_energy_plain, Average MERIC Energy = $avg_energy_rrl"
echo "Average Plain CPU Energy = $avg_cpu_energy_plain, Average MERIC CPU Energy = $avg_cpu_energy_rrl"
rm -rf PLAIN_*
rm -rf TUNED_*
