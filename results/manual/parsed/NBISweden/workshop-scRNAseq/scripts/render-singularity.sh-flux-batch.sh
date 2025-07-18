#!/bin/bash
#FLUX: --job-name=render
#FLUX: -n=4
#FLUX: --queue=core
#FLUX: -t=10800
#FLUX: --urgency=16

set -e
singularity_seurat="/sw/courses/scrnaseq/singularity/2024-seurat-r4.3.0.sif"
singularity_bioc="/sw/courses/scrnaseq/singularity/2024-bioconductor-r4.3.0.sif"
singularity_scanpy="/sw/courses/scrnaseq/singularity/2024-scanpy-py3.10.sif"
singularity_seurat_spatial="/sw/courses/scrnaseq/singularity/2024-seurat_spatial-r4.3.0.sif"
singularity_bioc_spatial="/sw/courses/scrnaseq/singularity/2024-bioconductor_spatial-r4.3.0.sif"
singularity_scanpy_spatial="/sw/courses/scrnaseq/singularity/2024-scanpy_spatial-py3.10.sif"
singularity_site="/sw/courses/scrnaseq/singularity/2024-site-r4.3.0.sif"
if [ ! -f "_quarto.yml" ]; then
    echo "Error: Are you in the root of the repo? _quarto.yml is missing."
    exit 1
fi
start=$(date +%s.%N)
echo "Rendering Seurat files..."
start_seurat=$(date +%s.%N)
singularity run -e $singularity_seurat quarto render labs/seurat/seurat_01_qc.qmd
singularity run -e $singularity_seurat quarto render labs/seurat/seurat_02_dimred.qmd
singularity run -e $singularity_seurat quarto render labs/seurat/seurat_03_integration.qmd
singularity run -e $singularity_seurat quarto render labs/seurat/seurat_04_clustering.qmd
singularity run -e $singularity_seurat quarto render labs/seurat/seurat_05_dge.qmd
singularity run -e $singularity_seurat quarto render labs/seurat/seurat_06_celltyping.qmd
singularity run -e $singularity_seurat quarto render labs/seurat/seurat_07_trajectory.qmd
singularity run -e $singularity_seurat_spatial quarto render labs/seurat/seurat_08_spatial.qmd
duration_seurat=$(echo "$(date +%s.%N) - $start_seurat" | bc) && echo "Seurat time elapsed: $duration_seurat seconds"
echo "Rendering Bioconductor files..."
start_bioc=$(date +%s.%N)
singularity run -e $singularity_bioc quarto render labs/bioc/bioc_01_qc.qmd
singularity run -e $singularity_bioc quarto render labs/bioc/bioc_02_dimred.qmd
singularity run -e $singularity_bioc quarto render labs/bioc/bioc_03_integration.qmd
singularity run -e $singularity_bioc quarto render labs/bioc/bioc_04_clustering.qmd
singularity run -e $singularity_bioc quarto render labs/bioc/bioc_05_dge.qmd
singularity run -e $singularity_bioc quarto render labs/bioc/bioc_06_celltyping.qmd
singularity run -e $singularity_bioc_spatial quarto render labs/bioc/bioc_08_spatial.qmd
duration_bioc=$(echo "$(date +%s.%N) - $start_bioc" | bc) && echo "Bioc time elapsed: $duration_bioc seconds"
echo "Rendering Scanpy files..."
start_scanpy=$(date +%s.%N)
singularity run -e $singularity_scanpy quarto render labs/scanpy/scanpy_01_qc.qmd
singularity run -e $singularity_scanpy quarto render labs/scanpy/scanpy_02_dimred.qmd
singularity run -e $singularity_scanpy quarto render labs/scanpy/scanpy_03_integration.qmd
singularity run -e $singularity_scanpy quarto render labs/scanpy/scanpy_04_clustering.qmd
singularity run -e $singularity_scanpy quarto render labs/scanpy/scanpy_05_dge.qmd
singularity run -e $singularity_scanpy quarto render labs/scanpy/scanpy_06_celltyping.qmd
singularity run -e $singularity_scanpy quarto render labs/scanpy/scanpy_07_trajectory.qmd
singularity run -e $singularity_scanpy_spatial quarto render labs/scanpy/scanpy_08_spatial.qmd
duration_scanpy=$(echo "$(date +%s.%N) - $start_scanpy" | bc) && echo "Scanpy time elapsed: $duration_scanpy seconds"
singularity run -e $singularity_seurat quarto render lectures/dge/index.qmd
singularity run -e $singularity_seurat quarto render lectures/gsa/index.qmd
singularity run -e $singularity_site quarto render index.qmd
singularity run -e $singularity_site quarto render home_contents.qmd
singularity run -e $singularity_site quarto render home_info.qmd
singularity run -e $singularity_site quarto render home_precourse.qmd
singularity run -e $singularity_site quarto render home_schedule.qmd
singularity run -e $singularity_site quarto render home_syllabus.qmd
singularity run -e $singularity_site quarto render other/uppmax.qmd
singularity run -e $singularity_site quarto render other/docker.qmd
singularity run -e $singularity_site quarto render other/containers.qmd
singularity run -e $singularity_site quarto render other/faq.qmd
singularity run -e $singularity_site quarto render other/data.qmd
singularity run -e $singularity_site quarto render labs/index.qmd
bash ./scripts/compile-singularity.sh
echo "All labs compiled successfully."
echo "Seurat time elapsed: $duration_seurat seconds"
echo "Bioc time elapsed: $duration_bioc seconds"
echo "Scanpy time elapsed: $duration_scanpy seconds"
duration=$(echo "$(date +%s.%N) - $start" | bc) && echo "Total time elapsed: $duration seconds"
echo "All files rendered successfully."
exit 0
