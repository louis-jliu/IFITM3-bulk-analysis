# Result tables behind the published panels

These files are byte-identical copies of the source files submitted with the figures. They
were renamed to match the output names of `scripts/02` and `scripts/04`.

| File | Submitted as | Panels | md5 |
|---|---|---|---|
| `DEres_5x_KO_5x.csv` | `2h-2i-DEres_5x_KO_5x.csv` | Fig. 2h, 2i | ddf1d4133ece707bf25310cd05ff3cba |
| `DEres_KO_WT.csv` | `2h-2j-DEres_KO_WT.csv` | Fig. 2h, 2j | 14d805780c803814d91136af8a80e57a |
| `DEres_interaction.csv` | `2i-2j-DEres_interaction.csv` | Fig. 2i, 2j | aef82acd5874e3202233f7657cc202c7 |
| `fgsea_wiki_interaction_sig.rds` | `2k-wiki_interaction_sig.rds` | Fig. 2k | d96c9b447938dd82d73064d15e7abe4b |
| `fgsea_go_5x_WT_sig.rds` | `Ex_2g-go_5x_WT_sig.rds` | Ext. Data Fig. 2g | 7ac0d96502ce89c141956c4ed0d473f3 |
| `microglia_program_meta_analysis_results.txt` | `5e-kellis_microglia_meta_analysis_results_V3.txt` | Fig. 5e | 8cc458a21e0e6a8c6b6795203eb1fb7f |

DESeq2 tables: one row per tested gene, with columns gene, baseMean, log2FoldChange, lfcSE,
stat, pvalue, padj and regulation (Up/Down: padj < 0.05 and |log2FC| > log2(1.5)).
The fgsea `.rds` files are R data frames of pathways with padj < 0.05.
