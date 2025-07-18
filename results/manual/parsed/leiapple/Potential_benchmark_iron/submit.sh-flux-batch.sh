#!/bin/bash
#FLUX: --job-name=IAP_test
#FLUX: -n=16
#FLUX: --queue=parallelshort
#FLUX: -t=7200
#FLUX: --urgency=16

rm dump*
rm *.csv
rm sfe*
rm -r ./data
rm -r ./plots
rm in.*
rm *.mod
rm *.py
rm results.txt
rm *.log
rm potential/potential.in
eaddress="lei.zhang@rug.nl"
module load OpenMPI/4.1.4-GCC-11.3.0
module load Python/3.10.4-GCCcore-11.3.0
LMMP="/home1/p301616/software/lammps_jace/build/lmp"
lmp_inps="/home1/p301616/pot_testing/lmps_inputs"
pps_python="/home1/p301616/pot_testing/py_pps"
pot="ace"
potfilename=`ls ${PWD}/potential/`
if [[ ${pot} = "ace" ]]; then
	pstyle="pace"
	pcoeff="${PWD}/potential/${potfilename} Fe"
elif [[ ${pot} = "gap" ]]; then
	pstyle="quip"
	pcoeff="${PWD}/potential/${potfilename} 'IP GAP' 26"
elif [[ ${pot} = "n2p2" ]]; then
	pstyle="hdnnp 6.5 dir ${PWD}/potential showew no showewsum 1000 resetew yes maxew 1000000 cflength 1 cfenergy 1"
	pcoeff="Fe"
elif [[ ${pot} = "ann" ]]; then
	pstyle="aenet"
	pcoeff="v-1 Fe 15tw-15tw.nn Fe"
elif [[ ${pot} = "mtp" ]]; then
	pstyle="mlip ${PWD}/potential/mlip.ini"
	poceff=""
fi
cat >./potential/potential.in <<EOF
pair_style ${pstyle}
pair_coeff * * ${pcoeff} 
EOF
mkdir data
fullpath=${PWD}
potential_name=`echo $(basename $fullpath)`
echo '#**********************************' | tee -a  ./data/results.txt
echo 'Potential basis set:' ${potential_name} | tee -a ./data/results.txt
awk '/^pair_style*/' ./potential/potential.in | tee -a ./data/results.txt
awk '/^pair_coeff*/' ./potential/potential.in | tee -a ./data/results.txt
echo '#**********************************' | tee -a ./data/results.txt
cp ${lmp_inps}/in.eos .
mpirun -n 4 ${LMMP} -in in.eos -v folder ${potential_name}
cp ${pps_python}/eos-fit.py .
python eos-fit.py
cp volume.dat ./data/eos_mlip.csv
a0=$(grep 'a0 =' ./data/results.txt | awk '{print $3}')
cp ${lmp_inps}/in.vac .
srun ${LMMP} -in in.vac -v lat ${a0}
cp ${lmp_inps}/in.elastic .
cp ${lmp_inps}/*.mod .
srun ${LMMP} -in in.elastic -v lat ${a0}
cp ${lmp_inps}/in.surf* .
srun ${LMMP} -in in.surf1 -v lat ${a0}
srun ${LMMP} -in in.surf2 -v lat ${a0}
srun ${LMMP} -in in.surf3 -v lat ${a0}
srun ${LMMP} -in in.surf4 -v lat ${a0}
cp ${lmp_inps}/in.bain_path .
${LMMP} -in in.bain_path -v lat ${a0}
cp bain_path.csv ./data
cp ${lmp_inps}/in.sfe_* .
srun ${LMMP} -in in.sfe_110 -v lat ${a0}
srun ${LMMP} -in in.sfe_112 -v lat ${a0}
cp ./sfe_110.csv ./data
cp ./sfe_112.csv ./data
cp ${lmp_inps}/in.ts_* .
srun ${LMMP} -in in.ts_100 -v lat ${a0}
srun ${LMMP} -in in.ts_110 -v lat ${a0}
cp ./ts_100.csv ./data
cp ./ts_110.csv ./data
cp -r /home1/p301616/pot_testing/REF_DATA . 
mkdir plots
cd plots
cp ${pps_python}/eos_bain.py .
cp ${pps_python}/sfe.py .
cp ${pps_python}/ts.py .
python eos_bain.py
python sfe.py
python ts.py
rm *.py
echo "Finish plotting results!"
cd ..
rm in.*
rm *.mod
mail -s "Basic Properties of iron predicted by IAP"  -a ./data/results.txt -a ./plots/eos_bp.png -a ./plots/sfe.png "${eaddress}" <<EOF
Please check the performance of interatomic potential: ${potential_name}
EOF
echo "Mail the results successful!"
