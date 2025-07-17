#!/bin/bash
#FLUX: --job-name=spicy-milkshake-0861
#FLUX: -n=4
#FLUX: --queue=core
#FLUX: -t=3600
#FLUX: --urgency=16

cd /proj/sens2022521/MindReader
julia --project "/proj/sens2022521/MindReader/src/ReadMind.jl" \
  --input "0001LB.edf" \
  --inputDir "/proj/sens2022521/EEGcohortMX/" \
  --params "Parameters.jl" \
  --paramsDir "/proj/sens2022521/MindReader/src/" \
  --annotation "0001LB.xlsx" \
  --annotDir "/proj/sens2022521/EEGcohortMX/" \
  --outDir "/proj/sens2022521/1-shuai/2-results/" \
  --additional "annotationCalibrator.jl,fileReaderXLSX.jl" \
  --addDir "/proj/sens2022521/EEG/src/annotation/functions/"
cd /proj/sens2022521/1-shuai/1-scripts
