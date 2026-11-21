# HW3: Eukaryotic RNA-seq Snakemake Workflow

Reproducible Snakemake workflow for processing human RNA-seq data (`hg38`/`GRCh38`).

## Project Structure
- `workflow/` - Snakefile, Conda environment definitions (`envs/`), and helper scripts (`scripts/`).
- `config/` - Configuration file (`config.yaml`) and sample sheet.
- `resources/` - Reference genome, transcriptome, and annotations (not tracked in Git).
- `data/` - Raw and trimmed sequencing reads (not tracked in Git).
- `results/` - Quality control reports, alignments, and quantification tables (not tracked in Git).

## Execution

1. Clone the repository and navigate into the project directory:
   ```bash
   git clone https://github.com/1cete/Eukaryotic_RNA-seq_analysis.git
   cd Eukaryotic_RNA-seq_analysis

   bash workflow/scripts/prepare_data.sh
   ```

2. Ensure Snakemake and Conda/Mamba are available, and configure sample paths in `config/config.yaml`.

3. Run the workflow (dry-run first to verify):
```bash
snakemake -n
snakemake --use-conda --cores 4
```
