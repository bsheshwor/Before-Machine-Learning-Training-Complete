# FastAPI Employee Management API

This project demonstrates the implementation of a simple Employee Management API using FastAPI and SQLite. The API supports basic CRUD operations (Create, Read, Update, Delete) for managing employee data.

## Features

- Retrieve a list of employees with pagination support.
- Get details of a specific employee by ID.
- Create a new employee.
- Update employee information.
- Delete an employee by ID.

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/fastapi-employee-management.git
   cd fastapi-employee-management
   ```
2. Create and activate a virtual environment:
   ```bash
      python -m venv venv
      source venv/bin/activate
   ```
3. Install the dependencies:
   ```bash
      pip install -r requirements.txt
   ```
4. Run the FastAPI application:
   ```bash
      uvicorn app.main:app --reload
   ```

## Usage

- The API will be available at http://127.0.0.1:8000.

## How to Use

- Access http://127.0.0.1:8000/docs to view the automatically generated Swagger documentation.
- Use an API client (e.g., Postman or curl) to interact with the API endpoints.

## Endpoints

- GET /employees/ : Retrieve a list of employees with pagination support.
- GET /employees/{employee_id} : Retrieve an employee by ID.
- POST /employees/ : Create a new employee.
- DELETE /employees/{employee_id} : Delete an employee by ID.
- PUT /employees/{employee_id}/{column}/{new_value} : Update an employee's information.


