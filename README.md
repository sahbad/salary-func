README - Salary Function Project 

📘 Overview

This project forms part of the Nexford University MSDA Module 2 Assignment, where the goal is to build a Salary Function System that loads, processes, and exports salary data in Python, then validates it in R.

The repository  - "salary-func" (https://github.com/sahbad/salary-func) demonstrates data cleaning, function-based programming, file handling, and cross-language integration (Python + R) using real salary data from San Francisco public employees.

🧩 Objectives

The project focuses on demonstrating:

Data Importing & Cleaning — using Pandas to load and prepare salary data.

Function Creation — defining reusable Python functions (employee_details, export_employee_profile).

Dictionary Processing — converting DataFrame segments into dictionaries for structured data manipulation.

Error Handling — implementing custom error classes and input validation.

Exporting — writing filtered employee data to a CSV and zipping the results.

R Integration — reading and displaying exported CSVs using an R script.

🏗️ Repository Structure

salary-func/
├─ data/                      # contains Salaries.csv dataset
├─ notebooks/                 # contains salary_func.ipynb Jupyter notebook
├─ r/                         # contains R script for unzip & display
│  └─ read_employee_profile.R
├─ output/                    # generated folder for exported ZIP and CSV files
├─ .gitignore                 # excludes virtual environments, cache, and large files
├─ requirements.txt           # Python dependencies
└─ README.md                  # project documentation

🧠 How It Works

Step 1 — Data Import & Cleaning

The dataset (Salaries.csv) is imported and cleaned using a function:

def load_salary_data(csv_path: Path) -> pd.DataFrame:
    df = pd.read_csv(csv_path, low_memory=False, na_values=["Not Provided", "None", "", "-", "N/A"])
    # Clean string and numeric columns
    ...
    return df

This ensures missing values are replaced with NaN, and numeric columns are properly converted.

Step 2 — Retrieve Employee Details

def employee_details(name: str, data: pd.DataFrame) -> pd.DataFrame:
    match = data[data["EmployeeName"].str.lower() == name.lower()]
    if match.empty:
        raise EmployeeNotFoundError(f"No record found for {name}")
    return match

This function searches for employees by name and returns their complete details.

Step 3 — Dictionary Processing

To demonstrate Python dictionary usage:

salary_dict = df[["EmployeeName", "JobTitle", "TotalPay"]].head(10).to_dict(orient="records")
for record in salary_dict[:3]:
    print(record)

This converts a small DataFrame sample into a list of dictionaries for quick access.

Step 4 — Export to CSV and ZIP

def export_employee_profile(name: str, data: pd.DataFrame) -> Path:
    rows = employee_details(name, data)
    csv_path = Path("../output/Employee Profile") / f"{name.replace(' ', '_')}_profile.csv"
    rows.to_csv(csv_path, index=False)
    with ZipFile("../output/Employee_Profile.zip", "w", ZIP_DEFLATED) as zipf:
        zipf.write(csv_path, arcname=f"Employee Profile/{csv_path.name}")

This exports an employee’s details into both CSV and ZIP formats for cross-language use.

Step 5 — Display with R

The R script unzips and prints the CSV file contents:

zip_path <- "output/Employee_Profile.zip"
unzip_dir <- "output/unzipped"

if (!dir.exists(unzip_dir)) dir.create(unzip_dir, recursive = TRUE)
utils::unzip(zipfile = zip_path, exdir = unzip_dir)
csvs <- list.files(unzip_dir, pattern="\\.csv$", full.names = TRUE, recursive = TRUE)
df <- read.csv(csvs[1])
print(head(df, 10))

This validates the exported data using R’s native CSV functions.

⚙️ Setup Instructions

1. Clone the Repository

git clone <YOUR_REPOSITORY_URL>
cd salary-func

2. Create a Virtual Environment

py -m venv .venv
.\.venv\Scripts\Activate.ps1

3. Install Dependencies

py -m pip install -r requirements.txt

4. Launch JupyterLab

jupyter lab

5. Run the Notebook Cells

Load the dataset

Test the functions

Export an employee profile (e.g., NATHANIEL FORD)

6. Run R Script

Rscript r/read_employee_profile.R

🧾 Example Output

Python Output (Export Confirmation)

✅ Exported: ..\output\Employee Profile\NATHANIEL_FORD_profile.csv
✅ Created zip: ..\output\Employee_Profile.zip
Zip exists? True

R Output (Unzipped CSV)

    EmployeeName                                       JobTitle  BasePay
1 NATHANIEL FORD GENERAL MANAGER-METROPOLITAN TRANSIT AUTHORITY 167411.2
  OvertimePay OtherPay Benefits TotalPay TotalPayBenefits Year
1           0 400184.2       NA 567595.4         567595.4 2011

🧹 Best Practices I Employed (Based on Instructions)

I Committed changes regularly:

git add .
git commit -m "Updated employee export and R verification"
git push

I Included the Employee_Profile.zip in my final submission.

I made use of comments to properly describe my code for easier readability and structure. 

🏁 Author & Credits

Student: Saheed Adebowale Badru

Program: MS Data Analytics

Institution: Nexford University

Assignment: Module 2 — Salary Function

Tools Used: Python (Pandas, ZipFile), R (utils), Jupyter Notebook, GitHub

