#!/bin/bash
#FLUX: --job-name=Mg08dist
#FLUX: -c=4
#FLUX: --queue=astro2_long
#FLUX: -t=432000
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

echo "now processing task id:: " ${SLURM_ARRAY_TASK_ID}
cont=0
tinit=0.0
tprevious=0.0
tend=1.0
composition='Mg08Fe12SiO4'
directory='Mg08Fe12SiO4/nov22/KIC1255b'
orbit='0th_orb'
p_orbit='0th_orb'
s_dist=1
SCRATCH_DIRECTORY=scratch/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}
echo ${SCRATCH_DIRECTORY}
echo ${SLURM_SUBMIT_DIR}
echo ${SLURM_ARRAY_TASK_ID} > 'id.txt'
echo ${cont} > 'cont.txt'
echo ${tinit} > 'tinit.txt'
echo ${tend} > 'tend.txt'
echo ${composition} > 'comp.txt'
echo ${s_dist} > 'sdist.txt'
cp -r ${SLURM_SUBMIT_DIR}/executables ./
cp ${SLURM_SUBMIT_DIR}/src/*.o ./
cp ${SLURM_SUBMIT_DIR}/input/*.in ./
cp ${SLURM_SUBMIT_DIR}/input.py ./
if [ $s_dist == 0 ]
then
cp ${SLURM_SUBMIT_DIR}/input_grid.csv ./input_grid.csv
elif [ $s_dist == 1 ]
then
cp ${SLURM_SUBMIT_DIR}/input_grid_short.csv ./input_grid.csv
fi
mkdir data
python3 input.py > python.out
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
cp ./dusty_tails_KIC1255b.in dusty_tails.in
input_file='input.txt'
n=1
while read line; do
if [ $n == 1 ] 
then 
s_0=$line
echo $s_0
fi
if [ $n == 2 ] 
then 
mdot=$line
echo $mdot
fi
if [ $n == 3 ] 
then 
geom=$line
echo $geom
fi
n=$((n+1))
done < $input_file
if [ $geom == 0 ] 
then
geom_s='day'
elif [ $geom == 1 ] 
then
geom_s='sph'
fi
echo $geom_s
if [ $cont == 1 ] 
then
if [ $s_dist == 1 ]
then
input_dir=/lustre/astro/bmce/Dusty_Tails/simulations/${directory}/sdist_1.75_mdot${mdot}_${geom_s}_t${tprevious}
elif [ $s_dist == 0 ]
then
input_dir=/lustre/astro/bmce/Dusty_Tails/simulations/${directory}/${p_orbit}/s${s_0}_mdot${mdot}_${geom_s}_t${tprevious}
fi
echo ${input_dir}
cp ${input_dir}/output_final_struct.bin input.bin
fi
if [ $s_dist == 0 ]
then
id_dir=/lustre/astro/bmce/Dusty_Tails/simulations/${directory}/${orbit}/s${s_0}_mdot${mdot}_${geom_s}_t${tinit}
elif [ $s_dist == 1 ]
then
id_dir=/lustre/astro/bmce/Dusty_Tails/simulations/${directory}/sdist_1.75_mdot${mdot}_${geom_s}_t${tinit}
fi
echo ${id_dir}
mkdir -p /lustre/astro/bmce/Dusty_Tails/simulations/${directory}/${orbit}
mkdir -p ${id_dir}
time ./executables/dusty_tails.exe > run.out
mv ./data/output.bin        ${id_dir}/output_struct.bin
mv ./data/output_final.bin  ${id_dir}/output_final_struct.bin
mv ./data/light_curve.bin   ${id_dir}/light_curve.bin
mv gmon.out                 ${id_dir}/gmon.out
mv id.txt                   ${id_dir}/id.txt
mv run.out                 ${id_dir}/runlog.out
cd ${SLURM_SUBMIT_DIR}
rm -rf ${SCRATCH_DIRECTORY}
exit 0
