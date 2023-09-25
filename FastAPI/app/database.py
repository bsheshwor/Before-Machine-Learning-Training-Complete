import sqlite3
from app.models import Employee

conn = sqlite3.connect("data.db")
cursor = conn.cursor()

def create_table():
    conn = sqlite3.connect("data.db")
    cursor = conn.cursor()
    try:
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS employees (
                id INTEGER PRIMARY KEY,
                name TEXT,
                department TEXT
            )
        """)
        conn.commit()
    finally:
        conn.close()


def get_employees(skip: int, limit: int):
    conn = sqlite3.connect("data.db")
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT * FROM employees LIMIT ? OFFSET ?", (limit, skip))
        rows = cursor.fetchall()
        employees = [Employee(id=row[0], name=row[1], department=row[2]) for row in rows]
        return employees
    finally:
        conn.close()


def get_employee(employee_id: int):
    conn = sqlite3.connect("data.db")
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT * FROM employees WHERE id = ?", (employee_id,))
        row = cursor.fetchone()
        if row:
            return Employee(id=row[0], name=row[1], department=row[2])
        else:
            return None
    finally:
        conn.close()


def insert_employee(employee: Employee):
    conn = sqlite3.connect("data.db")
    cursor = conn.cursor()
    try:
        cursor.execute("INSERT INTO employees (name, department) VALUES (?, ?)", (employee.name, employee.department))
        conn.commit()
        return employee
    finally:
        conn.close()


def delete_employee(employee_id: int):
    conn = sqlite3.connect("data.db")
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM employees WHERE id = ?", (employee_id,))
        conn.commit()
        return cursor.rowcount > 0
    finally:
        conn.close()

def update_employee(employee_id: int, column: str, new_value: str):
    conn = sqlite3.connect("data.db")
    cursor = conn.cursor()
    try:
        cursor.execute(f"UPDATE employees SET {column} = ? WHERE id = ?", (new_value, employee_id))
        conn.commit()
        return cursor.rowcount > 0
    finally:
        conn.close()

