# HW3: Eukaryotic RNA-seq Snakemake Workflow

Reproducible Snakemake workflow for processing human RNA-seq data (`hg38`/`GRCh38`).

## Project Structure
- `workflow/` - Snakefile, Conda environment definitions (`envs/`), and helper scripts (`scripts/`).
- `config/` - Configuration file (`config.yaml`) and sample sheet.
- `resources/` - Reference genome, transcriptome, and annotations (not tracked in Git).
- `data/` - Raw and trimmed sequencing reads (not tracked in Git).
- `results/` - Quality control reports, alignments, and quantification tables (not tracked in Git).
