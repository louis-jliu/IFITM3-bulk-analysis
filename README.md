# IFITM3-bulk-analysis

Analysis code and data accompanying the manuscript

> **The innate immunity protein IFITM3 modulates microglial states in Alzheimer's disease**
>
> Jain T.\*, Frost G.R.\*, Hur J.-Y., Chang J.C., Wong E., Liu C., Nikain C., Kehs Z., Cross A.C.,
> Li T., Jonas L.A., Liu L., Niu X., Schlachetzki J., Gorodetski L., Lim W.L., Yu G., Wang M.,
> Zhou X., Wang W., Li F., Sanford J., Khobrekar N.V., Evangelisti A., Sole Domenech S.,
> Miloushev V.Z., Funk C., Mazutis L., Lekaye C., Zou Y., Glass C.K., Keshari K.R., Cruchaga C.,
> Zhang B., Dey K., Leslie C., Studer L., Li Y.-M.
>
> *Nature Aging* (submitted, 2026). DOI: _to be added on publication_
>
> \* equal contribution. Corresponding authors: Yue-Ming Li (liy2@mskcc.org), Georgia R. Frost.

This repository covers the bulk RNA-seq interaction and gene set enrichment analyses and the
human microglial gene program meta-analysis performed by L. Liu, K. Dey and C. Leslie
(Computational and Systems Biology Program, Memorial Sloan Kettering Cancer Center).

It reproduces the following panels: **Fig. 2h, 2i, 2j, 2k; Extended Data Fig. 2g; Fig. 5e.**

Code maintainer: Jinrui (Louis) Liu, ORCID [0000-0003-0778-4701](https://orcid.org/0000-0003-0778-4701)

## Contents

```
data/       inputs (bulk counts, sample sheet, MSigDB gene sets, curated GO terms, gene programs)
results/    the exact result tables behind the manuscript figures
scripts/    analysis and plotting scripts (run in order)
```

| Script | What it does | Output |
|---|---|---|
| `scripts/00_build_gene_program_table.py` | Documents how `data/gene_programs/microglia_programs_Gan2024.tsv` was built from Gan et al. 2024 Table S1 (already done) | gene program table |
| `scripts/01_prepare_bulk_counts.R` | Gene x sample count matrix for the 15 mouse PFC samples | `output/bulk_*_N15.rds` |
| `scripts/02_bulk_deseq2_fgsea.R` | DESeq2 with an Ifitm3-KO x 5xFAD interaction term, and fgsea (MSigDB WikiPathways, GO) for every contrast | `output/DEres_*.csv`, `output/fgsea_*` |
| `scripts/03_extract_rosmap_microglia.py` | Extracts microglia from the ROSMAP snRNA-seq data | `output/rosmap_microglia_*.tsv` |
| `scripts/04_microglia_program_meta_analysis.R` | IFITM3+ vs IFITM3- microglia: per-gene effect sizes and random-effects meta-analysis per program and pathology stage | `output/microglia_program_meta_analysis_results.txt` |
| `scripts/05_make_figures.R` | Draws Fig. 2h-k, Ext. Data Fig. 2g and Fig. 5e | `output/figures/*.pdf` |

## Running

Run every script from the repository root.

Redraw the published panels from the exact result tables in `results/`:

```bash
Rscript scripts/05_make_figures.R
```

Re-run the full analysis, then draw the figures from the new results:

```bash
Rscript scripts/01_prepare_bulk_counts.R
Rscript scripts/02_bulk_deseq2_fgsea.R
python  scripts/03_extract_rosmap_microglia.py        # needs data/rosmap/alzheimers.h5ad (see data/README.md)
Rscript scripts/04_microglia_program_meta_analysis.R
IFITM3_FIG_INPUT=output Rscript scripts/05_make_figures.R
```

Set `IFITM3_DATA_DIR` or `IFITM3_OUT_DIR` to use other input or output folders.

## Software

- R (>= 4.3) with DESeq2, fgsea, dplyr, ggplot2, ggrepel and rmeta
  (`environment/install_R_packages.R`). Scripts 02 and 04 save `sessionInfo()` to `output/`.
- Python (>= 3.9) with anndata and pandas (`environment/requirements.txt`).

## Methods summary

**Bulk RNA-seq (Fig. 2h-k, Ext. Data Fig. 2g)**
- Mouse prefrontal cortex, 15 samples: WT n = 4, Ifitm3 KO n = 4, 5xFAD n = 4, 5xFAD;Ifitm3 KO n = 3.
- Filtering: mitochondrial and RIKEN (`Rik`) genes are removed, along with genes with <= 10
  total counts.
- Model: DESeq2 with `~ strain + condition + strain:condition` (reference: WT, Ifitm3 WT).
  Contrasts are listed in `02_bulk_deseq2_fgsea.R`.
- Differential expression: BH-adjusted p < 0.05 (with |log2FC| > log2(1.5) for Up/Down labels).
- GSEA: genes are ranked by log2 fold change and run through fgsea (minSize 15, maxSize 500)
  with MSigDB mouse v2024.1 WikiPathways and GO. Pathways with padj < 0.05 are reported.
- Ext. Data Fig. 2g shows a curated subset of synaptic and neurotransmitter GO terms
  (`data/EDFig2g_curated_GO_terms.txt`).
- In Fig. 2h-j, |log2FC| is capped at 5 for display and the Pearson r is computed on the capped values.

**Human microglia (Fig. 5e)**
- Data: ROSMAP snRNA-seq (Mathys et al., 2019), 1,920 microglia from 48 individuals.
- Microglia with log-normalised IFITM3 > 0 are IFITM3+.
- For each gene, the difference in mean expression (IFITM3+ minus IFITM3-, among cells that
  express the gene) and its SE are computed per pathology stage.
- Genes are combined per program with `rmeta::meta.summaries(method = "random")`.
- BH correction is applied across programs within each stage.
- tau < 0 means lower program expression in IFITM3+ microglia.

## Reproducibility notes

- fgsea estimates p values by sampling. `02_bulk_deseq2_fgsea.R` fixes the seed, but the
  submitted results were produced without one. A re-run therefore gives NES/p values within
  sampling error of `results/`; the figures are drawn from `results/` by default.
- ggrepel label positions are random; `05_make_figures.R` fixes the seed.

## Citation

If you use this code or data, please cite the manuscript above and the archived release of this
repository (Zenodo DOI: _to be added_). Citation metadata is in `CITATION.cff`.

## License

Code: MIT (see `LICENSE`). Data files keep their original licences (see `data/README.md`).
