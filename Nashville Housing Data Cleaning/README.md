### About Dataset 
This dataset contains information about housing sales in Nashville, TN such as property, owner, sales, and tax information.

### Data cleaning procedure.
1) Standardize Date Format: \n
   The goal is to ensure uniformity in date representation across the dataset, eliminating variations in date formats that might cause confusion or inaccuracies during 
   analysis.

Populate Property Address Data: The aim is to fill in missing or incomplete property address data, creating a more complete and accurate dataset for analysis.

Breaking Out Address into Individual Columns: This step involves dissecting the compound address field into separate columns for address, city, and state. This enhances data organization, simplifies querying, and supports better geographical analysis.

Change "Sold as Vacant" Field Values: By replacing "Y" and "N" with "Yes" and "No" in the "Sold as Vacant" field, the dataset gains clearer and more intuitive values, improving readability and interpretability.

Remove Duplicates Using Window Functions: The objective is to identify and eliminate duplicate records in the dataset using advanced techniques like window functions. This ensures data accuracy and prevents overrepresentation of certain entries.

Delete Unused Columns: Removing unnecessary or redundant columns streamlines the dataset and eliminates clutter. This simplifies analysis, reduces confusion, and optimizes data storage.
