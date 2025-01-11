# Predicting Residential Property Values for Cook County

#### Business Problem
The Cook County Assessor’s Office faced significant challenges in determining fair market values for over 1.8 million properties annually. Historical valuation methods lacked transparency and precision, leading to public dissatisfaction. This project aims to improve residential property valuation using machine learning techniques, enhancing accuracy and public trust.

#### Technical Details
- **Data Source**: Historical property sales data from Cook County
- **Machine Learning Models Tested**: 
  - Linear Regression (Baseline Model)
  - Lasso Regression
  - Forward Stepwise Selection on Linear Regression
  - Random Forest
- **Best Performing Model**: Linear Regression with Forward Stepwise Selection
  - **CV MSE**: 15.88 billion
  - **R²**: ~83.23%
- **Technology**: Python (Pandas, NumPy, scikit-learn, Matplotlib, Seaborn)
- **Deliverables**: [Code](https://github.com/javeriamalik06/Cook-County-Property-Valuation/blob/main/code.py) and [Final Report](https://github.com/javeriamalik06/Cook-County-Property-Valuation/blob/main/report.pdf)

#### Recommendation
The Cook County Assessor’s Office should adopt a linear regression model with forward stepwise selection for property valuation. This approach minimizes error while maintaining model simplicity, making it interpretable for stakeholders. By addressing historical biases and inaccuracies, the office can ensure equitable taxation and foster public confidence in the assessment process.
