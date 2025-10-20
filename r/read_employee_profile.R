# --- R Script to Unzip and Display Employee Profile ---

# Define paths to the zipped folder and output directory
zip_path <- "output/Employee_Profile.zip"
unzip_dir <- "../output/unzipped"

# Create the unzip directory if it doesn’t exist
if (!dir.exists(unzip_dir)) dir.create(unzip_dir, recursive = TRUE)

# Stop if the zip file does not exist yet
if (!file.exists(zip_path)) stop(paste("Zip file not found:", zip_path))

# Unzip the file to the output directory
utils::unzip(zipfile = zip_path, exdir = unzip_dir)

# Locate any CSV file inside the Employee Profile folder
csvs <- list.files(unzip_dir, pattern="\\.csv$", full.names = TRUE, recursive = TRUE)
if (length(csvs) == 0) stop("No CSV files found after unzipping.")

# If no CSVs are found, throw an error
if (length(csvs) == 0) stop("No CSV files found after unzipping.")

# Read the first CSV and display the first 10 rows
df <- read.csv(csvs[1])
print(head(df, 10))