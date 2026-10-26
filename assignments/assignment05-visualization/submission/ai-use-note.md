# AI Use Note


## Audit trail
* Do you see any flaws with this block of code. What are they?
* How to weight the mean more appropriately? What are some simple weighting methods?
* is it WTMEC2YR or WeightMEC?

## What AI helped with
Copilot has been used to check potential flaws with the provided `flawed-plot-code.R` code block. Copilot was also used to scout out which weighting methods can be used for more accurately representing the BMI column. Finally, Copilot was used to verify variable name.

## What I changed
Based on the responses given by Copilot, I summarized the following plotting issues for my draft plot and the provided flawed plot in `visual-audit-note.md`:
### **Changes I made to the flawed plot starter based on identifiable issues:**
> 1. I added factor levels to ensure consistent ordering with `mutate()` and `factor`.
> 1. Copilot suggested that another flaw with the flawed plot was that it used unweighted BMI average `mean_bmi` instead of applying a weighted average. 
>       * In the augmented code, `weighted_mean_bmi` is created to account for the survey weights (with `WeightMEC`) in the NHANES dataset, which is important for accurate representation of the population.
> 1. Added indication of group size with `n()`, where n in the summary is the number of records.
> 1. Changed the title and subtitle to be more descriptive and accurate (e.g., BMI –> Weighted BMI; adding context about NHANES cycles in the title), avoiding overclaiming. 
>       * The original title suggested a causal relationship ("Low income drives rising BMI"), which requires scrutinized experimental designs. The revised title and subtitle focus on the visual trends without implying causation.

### **Issues with my own draft plot:**
> 1. The median is unweighted. In my draft code block, `median(BMI, na.rm = TRUE)` gives the median of the observed sample, not necessarily a population-representative / survey estimate. 
> 1. Flawed NA filtering: `na.omit(MaritalClean, IncomeGroup)` in the draft code doesn’t select those columns. In the pipe, the whole nhanes data frame is passed to na.omit(). I should filder the intended columns explicitly instead:
        >> ```
        >> filter(!is.na(MaritalClean), !is.na(IncomeGroup))
        >> ```
> 3. Factor conversion depends on exact labels. Any IncomeGroup or MaritalClean value not included in its levels becomes NA. I should check that the listed levels match the actual unique levels with code such as:
> ```
> sort(unique(nhanes$IncomeGroup))
> ``` 


## How I verified the result
I checked the column suggested by Copilot with the actual `nhanes` data we're working with using `colnames()`. 

I also consulted our lecture demo, in which I find that the lectuerer did emphasize that the BMI used for plotting was still 'unweighted', which suggested the need to weight the variable.