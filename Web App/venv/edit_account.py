from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur

@app.route('/view-profile')
def view_profile():
    if session['user_type'] == "Admin":

        cur.execute('select DepartmentName from Department')
        department_list = cur.fetchall()

        cur.execute('select AdminFirstName, AdminLastName, AdminEmail from Admin, Department where DepartmentID = Admin_Department and DepartmentName = %s and AdminID != %s and AdminEmail != %s', (session['admin_department'], session['admin_id'], session['admin_email'],))
        department_admin = cur.fetchall()

        # get complaints resolved by admin
        cur.execute('select count(ComplaintID) from Complaint, Admin where Complaint_AdminID = AdminID and Complaint_AdminID = %s and ResolveDate is not null', (session['admin_id'],))
        resolved_object = cur.fetchall()

        cur.execute('select count(ComplaintID) from Complaint where ResolveDate is not null')
        total_resolved_object = cur.fetchall()

        percentage_resolved = round(resolved_object[0][0]/total_resolved_object[0][0],2)


        return render_template('admin-view-profile.html', department = department_list, department_admin = department_admin, percent = percentage_resolved)

    elif session['user_type'] == "Student":

        cur.execute('select ProgramName from Program')
        program_list = cur.fetchall()
        
        cur.execute('select StudentFirstName, StudentLastName, StudentEmail from Student, Program where ProgramID = Student_Program and ProgramName = %s and StudentID != %s and StudentEmail != %s and Batch = %s', (session['student_program'], session['student_id'], session['student_email'], session['student_batch'],))
        program_student = cur.fetchall()

        return render_template('student-view-profile.html', program = program_list, program_student = program_student)
        
    else:
        return redirect('/login')

@app.route('/edit-profile')
def edit_profile():

    if session['user_type'] == "Admin":
        
        cur.execute('select DepartmentName from Department')
        department_list = cur.fetchall()

        cur.execute('select AdminFirstName, AdminLastName, AdminEmail from Admin, Department where DepartmentID = Admin_Department and DepartmentName = %s and AdminID != %s and AdminEmail != %s', (session['admin_department'], session['admin_id'], session['admin_email'],))
        department_admin = cur.fetchall()

        return render_template('admin-profile-settings.html', department = department_list, department_admin = department_admin)

    elif session['user_type'] == "Student":

        cur.execute('select ProgramName from Program')
        program_list = cur.fetchall()
        
        cur.execute('select StudentFirstName, StudentLastName, StudentEmail from Student, Program where ProgramID = Student_Program and ProgramName = %s and StudentID != %s and StudentEmail != %s and Batch = %s', (session['student_program'], session['student_id'], session['student_email'], session['student_batch'],))
        program_student = cur.fetchall()

        return render_template('student-profile-settings.html', program = program_list, program_student = program_student)
        
    else:
        return redirect('/login')

@app.route('/edit-details', methods = ['GET', 'POST'])
def edit_details():
    if session['user_type'] == "Admin":

        admin_fname = ""
        admin_lname = ""
        admin_pass = ""

        try:
            admin_fname = request.form['a_fname']
        except:
            pass
        try:
            admin_lname = request.form['a_lname']
        except:
            pass
        try:
            admin_pass = request.form['a_pass']
        except:
            pass

        if len(admin_fname) == 0 and len(admin_lname) == 0 and len(admin_pass) == 0:
            # all input fields are empty
            pass
        elif len(admin_fname) != 0 and len(admin_lname) != 0 and len(admin_pass)!= 0:
            # no input fields are empty
            cur.execute('update Admin set AdminPassword = %s and AdminFirstName = %s and AdminLastName = %s where AdminID = %s and AdminEmail = %s', 
                    (admin_pass, admin_fname, admin_lname, session['admin_id'], session['admin_email'],))
            conn.commit()
        elif len(admin_fname) != 0 and len(admin_lname) == 0 and len(admin_pass) == 0:
            # only fname is not empty
            cur.execute('update Admin set AdminFirstName = %s where AdminID = %s and AdminEmail = %s', 
                    (admin_fname, session['admin_id'], session['admin_email'],))

            conn.commit()
        elif len(admin_fname) != 0 and len(admin_lname) != 0 and len(admin_pass) == 0:
            # fname and lname is not empty
            cur.execute('update Admin set AdminFirstName = %s and AdminLastName = %s where AdminID = %s and AdminEmail = %s', 
                    (admin_fname, admin_lname, session['admin_id'], session['admin_email'],))

            conn.commit()
        elif len(admin_fname) != 0 and len(admin_lname) == 0 and len(admin_pass) != 0:
            # fname and pass is not empty
            cur.execute('update Admin set AdminPassword = %s and AdminFirstName = %s where AdminID = %s and AdminEmail = %s', 
                    (admin_pass, admin_fname, session['admin_id'], session['admin_email'],))

            conn.commit()
        elif len(admin_fname) == 0 and len(admin_lname) != 0 and len(admin_pass) == 0:
            # only lname is not empty
            cur.execute('update Admin set AdminLastName = %s where AdminID = %s and AdminEmail = %s', 
                    (admin_lname, session['admin_id'], session['admin_email'],))

            conn.commit()
        elif len(admin_fname) == 0 and len(admin_lname) != 0 and len(admin_pass) != 0:
            # lname and pass is not empty
            cur.execute('update Admin set AdminPassword = %s and AdminLastName = %s where AdminID = %s and AdminEmail = %s', 
                    (admin_pass, admin_lname, session['admin_id'], session['admin_email'],))

            conn.commit()  
        elif len(admin_fname) == 0 and len(admin_lname) == 0 and len(admin_pass) != 0:
            # only pass is not empty
            cur.execute('update Admin set AdminPassword = %s where AdminID = %s and AdminEmail = %s', 
                    (admin_pass, session['admin_id'], session['admin_email'],))

            conn.commit()

        cur.execute('select DepartmentName from Department')
        department_list = cur.fetchall()

        cur.execute('select AdminFirstName, AdminLastName, AdminEmail from Admin, Department where DepartmentID = Admin_Department and DepartmentName = %s and AdminID != %s and AdminEmail != %s', (session['admin_department'], session['admin_id'], session['admin_email'],))
        department_admin = cur.fetchall()

        return render_template('admin-profile-settings.html', department = department_list, department_admin = department_admin, message = "Account details successfully changed!")

    elif session['user_type'] == "Student":

        cur.execute('select ProgramName from Program')
        program_list = cur.fetchall()

        cur.execute('select StudentFirstName, StudentLastName, StudentEmail, ProgramName, Batch from Student, Program where ProgramID = Student_Program and ProgramName = %s and StudentID != %s and StudentEmail != %s and Batch = %s', (session['student_program'], session['student_id'], session['student_email'], session['student_batch'],))
        program_student = cur.fetchall()

        student_fname = ""
        student_lname = ""
        student_id = ""
        student_program = ""
        student_pass = ""
        student_email = ""
        student_batch = ""

        try:
            student_fname = request.form['s_fname']
        except:
            pass
        try:
            student_lname = request.form['s_lname']
        except:
            pass
        try:
            student_id = request.form['s_id']
        except:
            pass
        try:
            student_program = request.form['s_program']
        except:
            pass
        try:
            student_pass = request.form['s_pass']
        except:
            pass
        try:
            student_email = request.form['email']
        except:
            pass
        try:
            student_batch = request.form['s_batch']
        except:
            pass

        if len(student_fname) != 0:
            cur.execute('update Student set StudentFirstName = %s where StudentID = %s and StudentEmail = %s', 
                            (student_fname, session['student_id'], session['student_email'],))

            conn.commit()

        if len(student_lname) != 0:
            cur.execute('update Student set StudentLastName = %s where StudentID = %s and StudentEmail = %s', 
                            (student_lname, session['student_id'], session['student_email'],))

            conn.commit()

        if len(student_id) != 0:

            cur.execute('select StudentID from StudentID where StudentID = %s', (student_id,))
            id_object = cur.fetchall()

            if len(id_object) == 0:
                cur.execute('update Student set StudentID = %s where StudentID = %s and StudentEmail = %s', 
                            (student_id, session['student_id'], session['student_email'],))

                conn.commit()
            else:
                return render_template('student-profile-settings.html', program = program_list, program_student = program_student, message = "This student ID already exists in the database!")

        if len(student_program) != 0:

            cur.execute('select ProgramID from Program where ProgramName = %s', (student_program,))
            program_id = cur.fetchall()

            cur.execute('update Student set Student_Program = %s where StudentID = %s and StudentEmail = %s', 
                            (program_id[0][0], session['student_id'], session['student_email'],))

            conn.commit()

        if len(student_email) != 0:

            cur.execute('select StudentEmail from Student where StudentEmail = %s', (student_email,))
            email_object = cur.fetchall()

            if len(email_object) == 0:
                cur.execute('update Student set StudentEmail = %s where StudentID = %s and StudentEmail = %s', 
                            (student_email, session['student_id'], session['student_email'],))

                conn.commit()
            else:
                return render_template('student-profile-settings.html', program = program_list, program_student = program_student, message = "This email address already exists in the database!")

        if len(student_pass) != 0:
            cur.execute('update Student set StudentPassword = %s where StudentID = %s and StudentEmail = %s', 
                            (student_pass, session['student_id'], session['student_email'],))

            conn.commit()

        if len(student_batch) != 0:
            
            cur.execute('update Student set Batch = %s where StudentID = %s and StudentEmail = %s', 
                            (str(student_batch), session['student_id'], session['student_email'],))

            conn.commit()

        return render_template('student-profile-settings.html', program = program_list, program_student = program_student, message = "Details updated successfully!")
        
    else:
        return redirect('/login')

    