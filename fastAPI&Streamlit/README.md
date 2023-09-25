# Streamlit Data Entry Application

This is a simple Streamlit application designed to manage employee and department data through an easy-to-use user interface. The application consists of three main pages: Employee Data Entry, Department Data Entry, and Visualization.

## Features

- **Employee Data Entry Page:** Enter employee information including Employee Number, Name, Job, and Department Number.

- **Department Data Entry Page:** Input department data including Department Number, Name, and Location.

- **Visualization Page:** Display a merged view of employee and department data based on the common 'Deptno' field.

## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/your-username/streamlit-data-entry-app.git
   ```

2. Navigate to the project folder:
   ```bash
   cd streamlit-data-entry-app
   ```

3. Install the required packages using pip (ensure you have Python and pip installed):
   ```bash
   pip install -r requirements.txt
   ```

4. Usage
- Run the Streamlit application:
   ```bash
   streamlit run app.py
   ```
- Open the provided URL in your web browser to access the application.
- Use the sidebar to navigate between different pages: Employee Data Entry, Department Data Entry, and Visualization.
- Fill in the required fields and click "Submit" to add data. Success messages and error handling are included.
