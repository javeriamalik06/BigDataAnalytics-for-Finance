#Problem Set 1
# Names: Ahmed Bilal, Shehzadi Mahum Agha, Javeria Malik




#######Loading Libraries#############

library(dplyr)
library(broom)
library(readr)
install.packages("here")
#####################################

library(here)
# Load a data file from the "data" folder
claims <- read.csv(here("claims (1).csv"))


#####################################
#Q4
#####################################

outcome_vars_q4 <- c("covg_0715_0716", "covg_1015_0716",
                  "diabetes_1015_0716", "hyperlipidemia_1015_0716", "hypertension_1015_0716",
                  "spendHosp_0715_0716", "spendOff_0715_0716", "spendRx_0715_0716", "spend_0715_0716",
                  "pcp_any_office_1015_0716", "pcp_any_visits_1015_0716", 
                  "pcp_total_office_1015_0716", "pcp_total_visits_1015_0716",
                  "pos_er_critical_1015_0716", "pos_hospital_1015_0716", "pos_office_outpatient_1015_0716")

# Calculate results
results_q4 <- lapply(outcome_vars_q4, function(outcome) {
  # Fit a linear model
  model_q4 <- lm(as.formula(paste(outcome, "~ treat")), data = claims)
  
  # Extract p-value for the treatment effect
  p_value <- summary(model_q4)$coefficients["treat", "Pr(>|t|)"]
  
  # Create a tibble with results
  tibble(
    Variable_Description = outcome,
    Control_Group_Mean = mean(claims[[outcome]][claims$treat == 0], na.rm = TRUE),
    Treatment_Group_Mean = mean(claims[[outcome]][claims$treat == 1], na.rm = TRUE),
    P_Value = round(p_value,3)
  )
}) %>%
  bind_rows()

# display results
print(results_q4)


####################################
#Q5
####################################

# Outcomes measured in the first year following randomization
outcome_vars <- c(
  "covg_0816_0717", "diabetes_0816_0717", "hyperlipidemia_0816_0717",
  "hypertension_0816_0717", "nonzero_spend_0816_0717", "pcp_any_office_0816_0717", 
  "pcp_total_office_0816_0717", "spendHosp_0816_0717", "spendOff_0816_0717", 
  "spendRx_0816_0717", "spend_0816_0717"
)

# Generate results
results_q5 <- lapply(outcome_vars, function(outcome) {
  # Model without controls
  model_no_controls <- lm(as.formula(paste(outcome, "~ treat")), data = claims)
  coef_no_controls <- tidy(model_no_controls) %>%
    filter(term == "treat") %>%
    select(estimate, std.error)
  
  # Model with demographic controls
  model_with_controls <- lm(as.formula(paste(outcome, "~ treat + male + white + age37_49 + age50")), data = claims)
  coef_with_controls <- tidy(model_with_controls) %>%
    filter(term == "treat") %>%
    select(estimate, std.error)
  
  # Combine results
  tibble(
    Variable_Description = outcome,
    No_Controls = sprintf("%.3f (%.3f)", coef_no_controls$estimate, coef_no_controls$std.error),
    With_Controls = sprintf("%.3f (%.3f)", coef_with_controls$estimate, coef_with_controls$std.error)
  )
}) %>%
  bind_rows()

#display results
print(results_q5)



#####################################
#Q6
#####################################
  
# Generate results
results_q6 <- lapply(outcome_vars, function(outcome) {
  # Model without controls
  model_no_controls <- lm(as.formula(paste(outcome, "~ completed_screening_nomiss_2016")), data = claims)
  coef_no_controls <- tidy(model_no_controls) %>%
    filter(term == "completed_screening_nomiss_2016") %>%
    select(estimate, std.error)
  
  # Model with demographic controls
  model_with_controls <- lm(as.formula(paste(outcome, "~ completed_screening_nomiss_2016 + male + white + age37_49 + age50")), data = claims)
  coef_with_controls <- tidy(model_with_controls) %>%
    filter(term == "completed_screening_nomiss_2016") %>%
    select(estimate, std.error)
  
  # Combine results
  tibble(
    Variable_Description = outcome,
    No_Controls = sprintf("%.3f (%.3f)", coef_no_controls$estimate, coef_no_controls$std.error),
    With_Controls = sprintf("%.3f (%.3f)", coef_with_controls$estimate, coef_with_controls$std.error)
  )
}) %>%
  bind_rows()

#display results
print(results_q6)




#######################################################################
#######################################################################

