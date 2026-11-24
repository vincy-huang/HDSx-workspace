# Dashboard Adaptation Note

## Audience

Public-health analysts preparing a concise briefing from the classroom NHANES equity dataset.

## Dashboard Question

For the selected income group, how has mean BMI changed across NHANES cycles among adults ages 20-80?

## KT Rationale

- **Who needs the information:** Public-health analysts preparing a short, evidence-based briefing for a professional audience.
- **What decision or conversation it supports:** The dashboard helps analysts compare descriptive mean-BMI patterns across NHANES cycles for a selected income group, identify questions for further discussion, and avoid making causal or nationally representative claims.
- **How the evidence should be communicated:** Use a clearly labeled income-group control, a summary table, and a mean-BMI line chart, with explicit scope, exclusions, and a concise description of the chart's unweighted, descriptive limits.

## Control And Interactive Visualization

- Control or interaction: the `selected_income` code value, used like a static dropdown.
- Visualization affected: the summary table and mean-BMI line chart.
- What changes when the control changes: the rows in the table and the title, subtitle, points, and line in the chart reflect the chosen income group.

## Before And After (changed element)

| Changed element | Original text | Revised text | Why the revision helps |
|---|---|---|---|
| Static dropdown instruction | "In a Shiny app, this would've become a dropdown." | "This income-group selection acts like a dashboard dropdown. In this static version, change `selected_income` and render again; the table and line chart both update." | Makes the control understandable and states that it updates both the table and visualization. |
| Plot subtitle and reading caption | "Adults age 20-80..." and "Descriptive, unweighted classroom summary..." | "Adults ages 20-80; selected from the prepared NHANES Health Equity classroom dataset" and "How to read: compare mean BMI across NHANES cycles..." | Names the cohort and prepared dataset, directs the user to the intended comparison, and states the exclusions and descriptive, unweighted limitation. |
| Plot title and dashboard description | "Mean BMI for [selected income group]" and "Dashboard for NHANES" | "How has mean BMI changed across NHANES cycles for [selected income group] adults ages 20-80?" and "Descriptive dashboard of unweighted mean BMI by income group across NHANES cycles, for classroom use." | Names the audience-facing question in the plot and gives the dashboard a clear, accurate classroom description. |

## Test Result

Rendered successfully from the repository root after changing `selected_income` from `"Low Income (<1.3)"` to `"Middle Income"`. The HTML shows `"Middle Income"` as the control result and includes the revised caption and instructions. See `testing-log.md`.

## Limitation

The dashboard is unweighted and descriptive; it does not estimate national prevalence or support causal claims about income and BMI.

## Privacy Check

The dashboard publishes only aggregate mean-BMI summaries and sample counts. It does not expose row-level NHANES records or provide small-cell conclusions, and the interpretation and caption explicitly state that the output is descriptive and unweighted.