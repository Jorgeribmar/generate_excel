#!/bin/bash

# Assign variables from command line arguments or use defaults
num_establishments=${1:-10}
num_classes=${2:-20}
num_teachers=${3:-20}
num_students=${4:-300}

echo "Using $num_establishments establishments, $num_classes classes, $num_teachers teachers, $num_students students."

# Generate random names using Python script
python generate_names.py $num_establishments $num_teachers $num_students

# Ensure the sheets directory exists
mkdir -p sheets

# Generate Establishments CSV
echo "id-establishment,name,identifier,street,postalCode,locality,country" > establishments.csv
i=1
while IFS= read -r name; do
    echo "$i,Ecole $name,$((RANDOM % 8999 + 1000)),${RANDOM} Main St,$((RANDOM % 89999 + 10000)),City $i,Country A" >> establishments.csv
    ((i++))
done < establishments_names.txt

# Generate Classes CSV
echo "id-class,id-establishment,name,grade" > classes.csv
for i in $(seq 1 $num_classes); do
  est_id=$(( (i - 1) / ($num_classes / $num_establishments) + 1 ))
  echo "$i,$est_id,Class $(( (i - 1) % ($num_classes / $num_establishments) + 1 )),Grade $(( RANDOM % 4 + 1 ))" >> classes.csv
done

# Generate Teachers CSV
echo "username,email,firstName,lastName,id-class" > teachers.csv
i=1
while IFS= read -r name; do
    first_name=$(echo "$name" | cut -d ' ' -f 1)
    last_name=$(echo "$name" | cut -d ' ' -f 2)
    echo "$first_name$last_name$i@teacher.com,$first_name$last_name$i@teacher.com,$first_name,$last_name,$i" >> teachers.csv
    ((i++))
done < teachers_names.txt

# Generate Students CSV
echo "username,email,firstName,lastName,id-class" > students.csv
i=1
while IFS= read -r name; do
    first_name=$(echo "$name" | cut -d ' ' -f 1)
    last_name=$(echo "$name" | cut -d ' ' -f 2)
    class_id=$(( (i - 1) / ($num_students / $num_classes) + 1 ))
    echo "$first_name$last_name$i@student.com,$first_name$last_name$i@student.com,$first_name,$last_name,$class_id" >> students.csv
    ((i++))
done < students_names.txt

# Convert each CSV to XLSX using ssconvert
for file in *.csv; do
  if command -v ssconvert &> /dev/null; then
    ssconvert "$file" "sheets/${file%.csv}.xlsx"
  else
    echo "ssconvert not found, please install Gnumeric to convert CSV to XLSX."
    exit 1
  fi
done

# Call the Python script to merge all XLSX files into one
if [ -f "merge_excel.py" ]; then
  python3 merge_excel.py
  echo "Combined Excel file created: education_import_generated.xlsx"
else
  echo "merge_excel.py not found, please ensure it is in the current directory."
fi

# Clean up CSV files and name lists
rm -f *.csv establishments_names.txt teachers_names.txt students_names.txt
echo "CSV and temporary name files have been deleted."

# Delete all .xlsx files in the 'sheets' folder except 'education_import_generated.xlsx'
find sheets -type f -name '*.xlsx' ! -name 'education_import_generated.xlsx' -exec rm {} +
echo "Temporary .xlsx files have been deleted."
