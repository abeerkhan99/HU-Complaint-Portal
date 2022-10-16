from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur

@app.route('/registration')
def register():

    cur.execute('select ProgramName from Program')
    program_list = cur.fetchall()

    cur.execute('select DepartmentName from Department')
    department_list = cur.fetchall()

    return render_template('register.html', program = program_list, department = department_list)


@app.route('/register-submit', methods = ['GET', 'POST'])
def register_submit():
    if request.method == 'POST':

        cur.execute('select ProgramName from Program')
        program_list = cur.fetchall()

        cur.execute('select DepartmentName from Department')
        department_list = cur.fetchall()

        user_type = request.form['u_type']
        first_name = request.form['fname']
        last_name = request.form['lname']
        user_id = request.form['s_id']
        user_email = request.form['email']
        user_password = request.form['password']
        user_p_d = request.form.get('program')
        

        if user_type == "Student":
            user_batch = request.form['s_batch']

            # check if id and email does not exist in database 
            cur.execute('select StudentID from Student where StudentID = %s', (user_id,))
            student_id_object = cur.fetchall()

            cur.execute('select StudentEmail from Student where StudentEmail = %s', (user_email,))
            student_email_object = cur.fetchall()

            if len(student_id_object) != 0 or len(student_email_object) != 0:

                if len(student_id_object) != 0:
                    return render_template('register.html', program = program_list, department = department_list, message = "This student ID already exists. Are you sure you do not have an account already?")
                else:
                    return render_template('register.html', program = program_list, department = department_list, message = "This student email already exists. Are you sure you do not have an account already?")

            else:
                # add student in database
                cur.execute('select ProgramID from Program where ProgramName = %s', (user_p_d,))
                program_id = cur.fetchall()

                cur.execute("insert into Student(StudentID, StudentFirstName, StudentLastName, StudentEmail, StudentPassword, Student_Program, Batch) VALUES(%s,%s, %s, %s, %s, %s, %s)", 
                            (user_id, first_name, last_name, user_password, user_email, program_id[0][0], user_batch))

                conn.commit()
                return render_template('login.html', message = "Registration successful! Please login.")


        elif user_type == "Admin":

            # check if id and email does not exist in database 
            cur.execute('select AdminID from Admin where AdminID = %s', (user_id,))
            admin_id_object = cur.fetchall()

            cur.execute('select AdminEmail from Admin where AdminEmail = %s', (user_email,))
            admin_email_object = cur.fetchall()

            if len(admin_id_object) != 0 or len(admin_email_object) != 0:
                if len(admin_id_object) != 0:
                    return render_template('register.html', program = program_list, department = department_list, message = "This admin ID already exists. Are you sure you do not have an account already?")
                else:
                    return render_template('register.html', program = program_list, department = department_list, message = "This admin email already exists. Are you sure you do not have an account already?")

            else:
                # add admin in database

                # check if admin information exists in Employee database
                cur.execute('select EmployeeID, EmployeeFirstName, EmployeeLastName from Employee where EmployeeID = %s and EmployeeFirstName = %s and EmployeeLastName = %s', (user_id, first_name, last_name))
                employee_admin_object = cur.fetchall()

                if len(employee_admin_object) == 0:
                    return render_template('register.html', program = program_list, department = department_list, message = "Invalid Admin information. Please try again or contact the Habib helpline.")
                
                else:
                    cur.execute('select DepartmentID from Department where DepartmentName = %s', (user_p_d,))
                    department_id = cur.fetchall()

                    cur.execute("insert into Admin(AdminID, AdminFirstName, AdminLastName, AdminEmail, AdminPassword, Admin_Department) VALUES(%s,%s, %s, %s, %s, %s)", 
                                (user_id, first_name, last_name, user_password, user_email, department_id[0][0]))

                    conn.commit()
                    return render_template('login.html', message = "Registration successful! Please login.")

    else:
        return render_template('login.html')