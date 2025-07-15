#!/bin/bash
#FLUX: --job-name=scruptious-kitty-1086
#FLUX: -t=21600
#FLUX: --priority=16

export PYTHIA8='/project/def-mdiamond/tomren/mathusla/pythia8308'
export PYTHIA8DATA='${MG5_Dir}/HEPTools/pythia8/share/Pythia8/xmldoc'

if [ $# -ne 2 ]; then
	echo "Usage: $0 <MG5 TopDirectory> <pT Cutoff>"
	echo "Note: MG5 TopDirectory should be the ABSOLUTE path"
	exit 1
fi
MG5_Dir=${1}
Scripts=`realpath ../Mu-Simulation/VectorExtraction/MadGraphScripts`
Extractor=`realpath ../Mu-Simulation/VectorExtraction/run_muon_extract.py`
Combiner=`realpath ../Mu-Simulation/VectorExtraction/combine_muon_data.py`
MadGraphScripts="${SLURM_TMPDIR}/MadGraphScripts"
MGDataDir="${SLURM_TMPDIR}/MadGraphOutput"
HepMCToText="${SLURM_TMPDIR}/HepMCToText"
G4Input="data/G4Input"
simulation=`realpath ../Mu-Simulation/simulation`
mkdir "${SLURM_TMPDIR}/MadGraphScripts"
mkdir "${SLURM_TMPDIR}/MadGraphOutput"
mkdir "${SLURM_TMPDIR}/HepMCToText"
mkdir "${SLURM_TMPDIR}/G4Input"
echo "Exporting PYTHIA8"
echo "Running initsim"
export PYTHIA8=/project/def-mdiamond/tomren/mathusla/pythia8308
export PYTHIA8DATA="${MG5_Dir}/HEPTools/pythia8/share/Pythia8/xmldoc"
PATH=$PATH:/project/def-mdiamond/tomren/mathusla/dlib-19.24/install
module load StdEnv/2020
module load qt/5.12.8
module load gcc/9.3.0
module load root/6.26.06
module load eigen/3.3.7
module load geant4/10.7.3
module load geant4-data/10.7.3
echo "PYTHIA8 paths:"
echo $PYTHIA8
echo $PYTHIA8DATA
NumSets=5
for (( c=0; c<NumSets; c++ )) # Generate NumSets*10000 MadGraph Events
do
  # Create the MadGraph Scripts for each set of each job
  echo "Creating MadGraph Scripts"
  seedval=$((c + NumSets * SLURM_ARRAY_TASK_ID))
  cp "${Scripts}/sm_muprod_wz.txt" "${MadGraphScripts}/sm_muprod_wz_${SLURM_ARRAY_TASK_ID}_${c}.txt"
  sed -i "14s/.*/set iseed = ${seedval}/" "${MadGraphScripts}/sm_muprod_wz_${SLURM_ARRAY_TASK_ID}_${c}.txt"
  sed -i "5s|.*|output ${MGDataDir}/proc_sm_muprod_wz_matched_${SLURM_ARRAY_TASK_ID}_${c}|" "${MadGraphScripts}/sm_muprod_wz_${SLURM_ARRAY_TASK_ID}_${c}.txt"
  sed -i "6s|.*|launch ${MGDataDir}/proc_sm_muprod_wz_matched_${SLURM_ARRAY_TASK_ID}_${c}|" "${MadGraphScripts}/sm_muprod_wz_${SLURM_ARRAY_TASK_ID}_${c}.txt"
  # Run Madgraph
  echo "Running MadGraph"
  ${MG5_Dir}/bin/mg5_aMC "${MadGraphScripts}/sm_muprod_wz_${SLURM_ARRAY_TASK_ID}_${c}.txt"
  HepMCDir="${MGDataDir}/proc_sm_muprod_wz_matched_${SLURM_ARRAY_TASK_ID}_${c}"
  # Unzip the data
  gzip -d "${HepMCDir}/Events/run_01/tag_1_pythia8_events.hepmc.gz"
  # Run the extractor
  echo "Extracting Muons"
  python3 ${Extractor} "${HepMCDir}/Events/run_01/tag_1_pythia8_events.hepmc" "${HepMCToText}/bkg_muon_${SLURM_ARRAY_TASK_ID}_${c}.txt" ${2}
  # Delete the data folder
  echo "Removing data folder"
  rm -rf "${HepMCDir}"
done # Generated NumSets text files of 10000 muon events
 # Combine the Text Files into One/Create Geant4 scripts
echo "Combining Text Files"
python3 ${Combiner} "${G4Input}" "${SLURM_ARRAY_TASK_ID}" "${NumSets}" "${HepMCToText}"
for (( c=0; c<NumSets; c++ ))
do
  rm "${HepMCToText}/bkg_muon_${SLURM_ARRAY_TASK_ID}_${c}.txt"
done
