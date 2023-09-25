from fastapi import FastAPI, HTTPException
from typing import List

from app.models import Employee
import app.database as database
app = FastAPI()

@app.on_event("startup")
def startup_event():
    database.create_table()

@app.get("/employees/", response_model=List[Employee])
def read_employees(skip: int = 0, limit: int = 10):
    return database.get_employees(skip, limit)

@app.get("/employees/{employee_id}", response_model=Employee)
def read_employee(employee_id: int):
    employee = database.get_employee(employee_id)
    if employee is None:
        raise HTTPException(status_code=404, detail="Employee not found")
    return employee

@app.post("/employees/", response_model=Employee)
def create_employee(employee: Employee):
    return database.insert_employee(employee)

@app.delete("/employees/{employee_id}")
def delete_employee(employee_id: int):
    if not database.delete_employee(employee_id):
        raise HTTPException(status_code=404, detail="Employee not found")
    return {"message": "Employee deleted"}

@app.put("/employees/{employee_id}/{column}/{new_value}")
def update_employee(employee_id: int, column: str, new_value: str):
    if not database.update_employee(employee_id, column, new_value):
        raise HTTPException(status_code=404, detail="Employee not found")
    return {"message": "Employee updated"}
