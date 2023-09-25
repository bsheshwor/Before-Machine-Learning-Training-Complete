import streamlit as st
import pandas as pd

# Initialize session_state variables
if 'employee_data' not in st.session_state:
    st.session_state.employee_data = pd.DataFrame(columns=['Empno', 'Ename', 'Job', 'Deptno'])

if 'department_data' not in st.session_state:
    st.session_state.department_data = pd.DataFrame(columns=['Deptno', 'Dname', 'Loc'])

def page_employee():
    """
    Renders the Employee Data Entry page.
    """
    st.header("Employee Data Entry")
    empno = st.text_input("Employee Number")
    ename = st.text_input("Employee Name")
    job = st.text_input("Job")
    deptno = st.text_input("Department Number")
    
    if st.button("Submit"):
        if empno and ename and job and deptno:
            st.session_state.employee_data.loc[len(st.session_state.employee_data)] = [empno, ename, job, deptno]
            st.success("Employee data submitted successfully!")
        else:
            st.error("Please fill in all fields.")

def page_department():
    """
    Renders the Department Data Entry page.
    """
    st.header("Department Data Entry")
    deptno = st.text_input("Department Number")
    dname = st.text_input("Department Name")
    loc = st.text_input("Location")
    
    if st.button("Submit"):
        if deptno and dname and loc:
            st.session_state.department_data.loc[len(st.session_state.department_data)] = [deptno, dname, loc]
            st.success("Department data submitted successfully!")
        else:
            st.error("Please fill in all fields.")

def page_visualization():
    """
    Renders the Visualization page.
    """
    st.header("Joined Employee and Department Data")
    
    # Merge employee and department data based on 'Deptno' field
    joined_data = pd.merge(st.session_state.employee_data, st.session_state.department_data, on='Deptno', how='inner')
    
    # Visualize the merged data
    st.dataframe(joined_data)

def main():
    """
    Main function to run the Streamlit Data Entry Application.
    """
    st.title("Data Entry Application")
    menu = ["Employee Data Entry", "Department Data Entry", "Visualization"]
    choice = st.sidebar.selectbox("Select Page", menu)
    
    if choice == "Employee Data Entry":
        page_employee()
    elif choice == "Department Data Entry":
        page_department()
    else:
        page_visualization()

if __name__ == "__main__":
    main()
