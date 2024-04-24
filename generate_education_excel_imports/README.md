# Generate eduction import

This project automates the generation and handling of random educational data, including establishments, teachers, and students. It utilizes a Python script for data generation with the Faker library and a bash script for data transformation and file management.

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Ensure you have the following installed on your system:

- **Python 3.x**
- **pip** (Python package installer)
- **Bash** (Unix shell, available by default on Unix/Linux systems, for Windows use WSL or Git Bash)
- **Gnumeric** (for `ssconvert`, necessary for converting CSV files to Excel)

### Installation

#### Python and Faker Library

Install Python from [python.org](https://www.python.org/downloads/), if not already installed. 

**Set up a Virtual Environment**:
   It's a good practice to use a virtual environment for Python projects to avoid conflicts between project dependencies. Set up a new virtual environment by running:

   ```bash
   python -m venv venv
   ```

Activate the virtual environment:

On Windows:

```bash
.\venv\Scripts\activate
```

On Unix or macOS:
```bash
source venv/bin/activate
```

deactivate venv when finish:
```bash
deactivate
```

Then, install Faker:

```bash
pip install faker
```

### Gnumeric
Install Gnumeric to use ssconvert. Installation commands vary by system:

### Debian/Ubuntu:

```bash
sudo apt-get install gnumeric
```
### macOS (using Homebrew):

```bash
brew install gnumeric
```

## Project Files
<!-- Clone the repository and navigate to the directory:

bash
Copy code
git clone https://github.com/yourusername/yourrepository.git
cd yourrepository -->
## Usage

### Generate Names

Run the Python script generate_names.py to generate names for establishments, teachers, and students. Specify the desired number of each as command line arguments:

```bash
python generate_names.py 10 20 300  # arguments: establishments, teachers, students
```

### Running the Bash Script
Make the Bash script executable and run it, specifying the number of establishments, classes, teachers, and students:

```bash

chmod +x create_excel_import_education.sh
./create_excel_import_education.sh 10 20 20 300
```

This will generate CSV files, convert them to Excel format, and merge them into a single Excel file named education_import_generated.xlsx located in the sheets folder.

### Cleaning Up
After running the scripts, all intermediate CSV and individual Excel files are cleaned up, leaving only the final combined Excel file.

## Troubleshooting
- Python or Pip Not Found: Ensure Python and Pip are correctly installed and added to your system's PATH.
- Permission Errors: If you encounter permission errors when running the scripts, make sure they are executable:
```bash
chmod +x generate_names.py
chmod +x create_excel_import_education.sh
```

- ssconvert Not Found: Ensure Gnumeric is installed correctly and ssconvert is accessible in your PATH.
