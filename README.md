# crystal-violet-OD-analysis
R workflow for descriptive statistics and ANOVA/Kruskal-Wallis on OD measurements.

# Crystal Violet OD Analysis - Multiple Treatments

A reproducible R workflow to analyze Crystal Violet optical density (OD) data across three treatment groups.

This repository demonstrates:
- Data reshaping (wide → long format using `pivot_longer`)  
- Descriptive statistics per treatment  
- Normality testing (Shapiro-Wilk test)  
- Statistical testing (ANOVA or Kruskal-Wallis depending on normality)  
- Visualization (boxplots and barplots with mean ± SD)  
- Reproducibility and clean coding practices  
---

## Dataset

- Excel file: `data/Crystal Violet.xlsx`  
- Columns represent three treatment groups:  
  - Treatment A  
  - Treatment B  
  - Treatment C  
- Each row represents a replicate measurement.  

**Note:** This dataset is for demonstration purposes. Users can replace it with their own OD measurements of the same structure to run the workflow.

Example Excel structure:

| Treatment A | Treatment B | Treatment C |
|-------------|-------------|-------------|
| 0.873       | 0.908       | 0.690       |
| 0.957       | 1.216       | 0.636       |
| 0.916       | 0.879       | 0.633       |
| 0.900       | 0.871       | 0.805       |

---

## Usage

1. Place your Excel dataset in the `data/` folder.  
2. Open `crystal_violet_OD.R` in RStudio or another R IDE.  
3. Run the script.  
4. Outputs:
   - Console: Descriptive statistics, Shapiro-Wilk results, ANOVA/Kruskal-Wallis outputs  
   - Boxplot: standard R boxplot  
   - Bar plot: `ggplot2` barplot with mean ± SD (generated in R)  

---

## Dependencies

- R 4.0+  
- Libraries:
  - `readxl`
  - `dplyr`
  - `tidyr`
  - `fitdistrplus`
  - `ggplot2`

Install packages if needed:

```r
install.packages(c("readxl","dplyr","tidyr","fitdistrplus","ggplot2"))

Notes
  ANOVA/Kruskal-Wallis results are for demonstration purposes only; small sample sizes (4 replicates per treatment) limit statistical power.
  The workflow is generalizable: users can replace the demonstration Excel file with their own OD measurements to reproduce all analysis steps.
  Boxplots and barplots visualize the data per treatment group.
