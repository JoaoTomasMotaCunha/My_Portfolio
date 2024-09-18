# Final Assignment - Next Generation Sequencing (NGS)

## Overview

This project involves performing SNP (Single Nucleotide Polymorphism) calling using Next Generation Sequencing (NGS) data. The analysis includes downloading sequencing data, aligning reads to a reference genome, processing alignment files, and calling variants.

**Author**: João Cunha  
**Student ID**: 202103227  
**Program**: Mestrado Bioinformática e Biologia Computacional

## Workflow

The project follows these steps:

1. **Setup Working Directory**
2. **Download Reference Genome and BED File**
3. **Download SRA Sequences**
4. **Prepare Reference Genome**
5. **Map Sequences and Create SAM Files**
6. **Process SAM Files to BAM Files**
7. **Call Variants**
8. **Apply MAF Filter**
9. **Cleanup**

## Prerequisites

- **bwa**: Burrows-Wheeler Aligner
- **samtools**: Tools for manipulating alignments in SAM/BAM format
- **bcftools**: Tools for variant calling and manipulation
- **vcftools**: Tools for working with VCF files
- **wget**: Command-line utility for downloading files

## Instructions

### 1. Setup Working Directory

Create and navigate to the working directory:

```bash
mkdir assig3
cd assig3
