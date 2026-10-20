"""Reusable helpers for NHANES BMI summaries."""
# AI-USE note:
# The untranslated R functions (bmi_summary, parity_table) were written by me without AI.
# This Python helper translation of both functions was written with AI assistance for use in translation.ipynb.
#
# Verified by: matching output shape/columns against the R parity_table(nhanes)
# and confirming import + execution from the notebook.

import pandas as pd


def bmi_summary(df: pd.DataFrame) -> pd.DataFrame:
    """
    Filter out rows where IncomeGroup or BMI is the string "NA",
    then compute mean / sd / median / max / min BMI by IncomeGroup and Gender.
    """
    return (
        df.loc[(df["IncomeGroup"] != "NA") & (df["BMI"] != "NA")]
        .groupby(["IncomeGroup", "Gender"], as_index=False)
        .agg(
            mean_BMI=("BMI", "mean"),
            sd_BMI=("BMI", "std"),
            median_BMI=("BMI", "median"),
            max_BMI=("BMI", "max"),
            min_BMI=("BMI", "min"),
        )
    )


def parity_table(df: pd.DataFrame) -> pd.DataFrame:
    unfiltered = (
        df.groupby(["IncomeGroup", "Gender"], as_index=False)
        .size()
        .rename(columns={"size": "unfiltered_count"})
    )

    # Exclude both the string "NA" and real missing values
    mask = (
        (df["IncomeGroup"] != "NA")
        & (df["BMI"] != "NA")
        & df["IncomeGroup"].notna()
        & df["BMI"].notna()
    )

    filtered = (
        df.loc[mask]
        .groupby(["IncomeGroup", "Gender"], as_index=False)
        .agg(
            filtered_count=("BMI", "size"),
            mean_BMI=("BMI", "mean"),
            sd_BMI=("BMI", "std"),
            median_BMI=("BMI", "median"),
            max_BMI=("BMI", "max"),
            min_BMI=("BMI", "min"),
        )
    )

    for col in ["mean_BMI", "sd_BMI", "median_BMI", "max_BMI", "min_BMI"]:
        filtered[col] = filtered[col].round(2)

    return unfiltered.merge(filtered, on=["IncomeGroup", "Gender"], how="outer")
