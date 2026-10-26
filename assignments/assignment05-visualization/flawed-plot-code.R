# Flawed plot for the Week 6 visual audit studio.
# This script intentionally contains planted problems. Audit it, list the
# issues with their categories, then revise the plot so the visual matches
# the evidence.

library(readr)
library(dplyr)
library(ggplot2)

candidate_paths <- c("C:/Users/analyst/Desktop/nhanes_equity_v6.csv",
  "examples/nhanes-equity/data/nhanes_equity_v6.csv",
  "../../../examples/nhanes-equity/data/nhanes_equity_v6.csv"
)

data_path <- candidate_paths[file.exists(candidate_paths)][1]
if (is.na(data_path)) {
  stop("Could not find nhanes_equity_v6.csv")
}

nhanes <- read_csv(data_path, show_col_types = FALSE)

cycle_levels <- sort(unique(nhanes$Cycle))
endpoint_cycles <- c(cycle_levels[1], cycle_levels[length(cycle_levels)])

flawed_summary <- nhanes |>
  filter(!is.na(BMI), !is.na(IncomeGroup), Cycle %in% endpoint_cycles) |>
  group_by(Cycle, IncomeGroup) |>
  summarise(
    mean_bmi = mean(BMI),
    .groups = "drop"
  )

flawed_plot <- ggplot(
  flawed_summary,
  aes(x = Cycle, y = mean_bmi, color = IncomeGroup, group = IncomeGroup)
) +
  geom_point(size = 3) +
  geom_line(linetype = "dashed", linewidth = 1) +
  scale_y_continuous(limits = c(24, 28)) +
  labs(
    title = "Low income drives rising obesity in American adults",
    subtitle = "Adults age 20-80: BMI climbed steadily across every NHANES cycle",
    x = "NHANES cycle",
    y = "BMI",
    color = "Income"
  ) +
  theme_minimal(base_size = 12)

print(flawed_plot)

# AI-EDIT(2026-06-11): MIT-067 — needs review
# Not a planted flaw: this save step guarantees you can see the figure even if
# no plot viewer pane opens. The PNG is written to your current working folder
# (run getwd() to see where). Find flawed-plot.png in the Explorer, right-click
# it, and choose Open Preview.
ggsave("flawed-plot.png", flawed_plot, width = 7, height = 5)
