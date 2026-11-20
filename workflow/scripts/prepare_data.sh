#!/usr/bin/env bash
set -euo pipefail

mkdir -p data/raw resources

echo "=== 1. Downloading RNA-seq FASTQ files from ENA ==="

declare -A SAMPLES=(
  ["N61311_Dex"]="SRX384346"
  ["N052611_untreated"]="SRX384349"
  ["N080611_untreated"]="SRX384353"
  ["N080611_Alb"]="SRX384355"
)

for sample in "${!SAMPLES[@]}"; do
  srx="${SAMPLES[$sample]}"
  echo "Fetching URLs for $sample ($srx)..."
  urls=$(curl -s "https://www.ebi.ac.uk/ena/portal/api/filereport?accession=${srx}&result=read_run&fields=fastq_ftp" | tail -n 1)
  
  IFS=';' read -ra ADDR <<< "$urls"
  url1="https://${ADDR[0]}"
  url2="https://${ADDR[1]}"
  
  echo "Downloading ${sample}_1.fastq.gz..."
  wget -nc -q --show-progress "$url1" -O "data/raw/${sample}_1.fastq.gz"
  echo "Downloading ${sample}_2.fastq.gz..."
  wget -nc -q --show-progress "$url2" -O "data/raw/${sample}_2.fastq.gz"
done

echo "=== 2. Downloading GENCODE GRCh38 reference files ==="

GENCODE_RELEASE="47"
BASE_URL="https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_${GENCODE_RELEASE}"

wget -nc -q --show-progress "${BASE_URL}/GRCh38.primary_assembly.genome.fa.gz" -O resources/GRCh38.primary_assembly.genome.fa.gz
wget -nc -q --show-progress "${BASE_URL}/gencode.v${GENCODE_RELEASE}.primary_assembly.annotation.gtf.gz" -O resources/gencode.v${GENCODE_RELEASE}.primary_assembly.annotation.gtf.gz
wget -nc -q --show-progress "${BASE_URL}/gencode.v${GENCODE_RELEASE}.transcripts.fa.gz" -O resources/gencode.v${GENCODE_RELEASE}.transcripts.fa.gz

echo "=== 3. Decompressing reference files ==="
gunzip -kf resources/GRCh38.primary_assembly.genome.fa.gz
gunzip -kf resources/gencode.v${GENCODE_RELEASE}.primary_assembly.annotation.gtf.gz
gunzip -kf resources/gencode.v${GENCODE_RELEASE}.transcripts.fa.gz

echo "All data and reference files are ready!"
