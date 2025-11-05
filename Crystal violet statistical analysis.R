# Crystal Violet OD Analysis - Multiple Treatments
# =========================================

# Load Libraries
library(readxl)
library(dplyr)
library(fitdistrplus)
library(ggplot2)
library(tidyr)

# Step 1: Load the data
# -------------------------
# CSV file: Crystal Violet.xlsx
# Columns: Treatment A, Treatment B, Treatment C

data <- read_xlsx("C:/Users/jessi/OneDrive/Desktop/Crystal Violet.xlsx")

# Convert to long format: Treatment | OD
long_data <- data %>%
  pivot_longer(
    cols = c(`Treatment A`,`Treatment B`,`Treatment C`),
    names_to = "Treatment",
    values_to = "OD"
  )
  
print(long_data)

# Step 2: Descriptive statistics per treatment
# -------------------------
summary_data <- long_data %>%
  group_by(Treatment) %>%
  summarise(
    mean_OD = mean(OD, na.rm = TRUE),
    median_OD = median(OD, na.rm = TRUE),
    sd_OD = sd(OD, na.rm = TRUE),
    min_OD = min(OD, na.rm = TRUE),
    max_OD = max(OD, na.rm = TRUE),
    n = sum(!is.na(OD)),
    .groups = 'drop'
  )
print(summary_data)


# Step 3: Normality test per treatment
# -------------------------
shapiro_results <- by(long_data$OD, long_data$Treatment, shapiro.test)
print(shapiro_results)

# Extract p-values
normality_pvals <- sapply(shapiro_results, function(x) x$p.value)
print(normality_pvals)

# Step 4: Statistical test
# -------------------------
if(all(normality_pvals > 0.05)){
  cat("\nAll groups pass normality. Performing ANOVA...\n")
  
  anova_result <- aov(OD ~ Treatment, data = long_data)
  print(summary(anova_result))
  
  tukey_result <- TukeyHSD(anova_result)
  print(tukey_result)
  
} else {
  cat("\nAt least one group fails normality. Performing Kruskal-Wallis test...\n")
  
  kruskal_result <- kruskal.test(OD ~ Treatment, data = long_data)
  print(kruskal_result)
}

# Step 5: Boxplot
# -------------------------
boxplot(OD ~ Treatment, data = long_data,
        col = c("lightblue", "lightgreen", "pink"),
        main = "Crystal Violet OD by Treatment",
        ylab = "OD values")

# Step 6: Bar plot with ggplot2
# -------------------------
ggplot(summary_data, aes(x=Treatment, y=mean_OD, fill=Treatment)) +
  geom_bar(stat="identity", color="black", width=0.6) +
  geom_errorbar(aes(ymin=mean_OD - sd_OD, ymax=mean_OD + sd_OD), width=0.2) +
  labs(title="Crystal Violet OD by Treatment", y="Mean OD ± SD", x="Treatment") +
  theme_minimal() +
  scale_fill_manual(values=c("lightblue","lightgreen","pink"))

