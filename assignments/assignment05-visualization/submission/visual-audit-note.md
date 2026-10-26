# Visual Audit Note

## Plot Question
 * How does the average BMI differ across different income groups for the 1999-2000 and 2021-2023 survey cycles?

### **Changes I made to the flawed plot starter based on checked issues:**
| Issue | Category | Why it matters | Correction |
|---|---|---|---|
| The Y-axis currently starts at 22 instead of 0* | *Correctness* | *Exaggerates the BMI gap between groups, suggesting a larger difference than the data actually is* | *Start the y-axis at 0 and state the axis choice in the caption* |
|The original title suggested a causal relationship ("Low income drives rising BMI"), which requires scrutinized experimental designs. | Correctness |A plot alone cannot establish or overclaim causality between variables. |Changed the title and subtitle to be more descriptive and accurate (e.g., BMI –> Weighted BMI; adding context about NHANES cycles in the title), avoiding overclaiming. |
|The income group legend has `Middle Income` at the bottom when it should be in the middle to represent its intermediate level more appropriately| Design |Plot readers may be scanning the graph quickly but get the wrong interpretation from the inorder legend levels. |I added factor levels to ensure consistent ordering with `mutate()` and `factor`|
|Mean BMI on the Y axis is not weighted| Interpretation |Weighting the mean BMI is important because unweighted values may give an inaccurate representation of the population| `weighted_mean_bmi` is created to account for the survey weights (with `WeightMEC`) in the NHANES dataset, and indication of group size with `n()` is added in the summary statistics|

## Final Caption
* Source: NHANES. Points show weighted mean BMI (scale starting from 0) by income groups for the 1999-2000 and 2021-2023 survey cycles. Records with missing BMI or income group were excluded. Limitations: the plot does not support causal inference, and the weighted mean BMI may not fully capture the distribution of BMI values within each income group due potential bias in the weight applied.

## AI-Use Check
State what AI helped with and how the code, labels, and claims were verified.

## AI Audit trail
* Do you see any flaws with this block of code. What are they?
* How to weight the mean more appropriately? What are some simple weighting methods?
* is it WTMEC2YR or WeightMEC?

## What AI helped with
Copilot has been used to check potential flaws with the provided `flawed-plot-code.R` code block. Copilot was also used to scout out which weighting methods can be used for more accurately representing the BMI column. Finally, Copilot was used to verify variable name.

### **Issues with my own draft plot:**

| Issue | Category | Why it matters | Correction |
|---|---|---|---|
|Flawed NA filtering: `na.omit(MaritalClean, IncomeGroup)` in the draft code doesn’t select those columns.| Correctness |Incorrect NA filtering can lead to incorrect value displaying on the plot|I filtered the intended columns explicitly using `filter(!is.na(MaritalClean), !is.na(IncomeGroup))` instead|
The income group legend has `Middle Income` at the bottom when it should be in the middle to represent its intermediate level more appropriately| Design |Plot readers may be scanning the graph quickly but get the wrong interpretation from the inorder legend levels. |I added factor levels to ensure consistent ordering with `mutate()` and `factor`|
|The median BMI is unweighted.| Interpretation |Weighting the mean BMI is important because unweighted values may give an inaccurate representation of the population| `weighted_mean_bmi` is created to account for the survey weights using `WeightMEC`|

## Final Caption
* Source: NHANES. The plot shows median BMI by income group and marital status. Records with missing BMI, income group, or marital status were excluded. Limitations: the plot does not support causal inference, and the median BMI may not fully capture the distribution of BMI values within each income group due to potential bias in the weight applied.

## AI-Use Check
* Same as above.