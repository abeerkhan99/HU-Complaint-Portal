from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur

@app.route('/login')
def login():
    return render_template('login.html')


@app.route('/submit', methods = ['GET', 'POST'])
def submit():
    try:
        if request.method == 'POST':

            uemail = request.form['email']
            upassword = request.form['password']

            print('PASS: ', upassword)
            print('EMAIL:', uemail)

            # check if it's student email or admin email
            if '@st.habib.edu.pk' in uemail:
                #student email

                # check if email exists in database
                cur.execute('select StudentEmail from Student where StudentEmail = %s', (uemail,))
                student_e = cur.fetchall()

                if len(student_e) != 0:
                    # if email exists in database
                    # then check if email and password combination match

                    cur.execute('select StudentPassword from Student where StudentEmail = %s', (uemail,))

                    student_p = cur.fetchall()

                    if student_p[0][0] == str(upassword):
                        print("SUCCESS")
                        
                        cur.execute('select StudentFirstName, StudentLastName, StudentID, ProgramName, Batch from Student, Program where StudentEmail = %s and ProgramID = Student_Program', (uemail,))

                        student_info = cur.fetchall()
                        print(student_info)

                        #sessions
                        session['student_id'] = student_info[0][2]
                        session['student_fname'] = student_info[0][0]
                        session['student_lname'] = student_info[0][1]
                        session['student_program'] = student_info[0][3]
                        session['student_email'] = uemail
                        session['student_batch'] = student_info[0][4]
                        session['user_type'] = "Student"

                        return redirect('/dashboard')
                    else:
                        print('FAIL')
                        return render_template('login.html', message = "Incorrect password")
                else:
                    print('FAIL')
                    return render_template('login.html', message = "Incorrect email")

            else:
                # admin email

                # check if email exists in database
                cur.execute('select AdminEmail from Admin where AdminEmail = %s', (uemail,))
                admin_e = cur.fetchall()

                if len(admin_e) != 0:
                    # if email exists in database
                    # then check if email and password combination match

                    cur.execute('select AdminPassword from Admin where AdminEmail = %s', (uemail,))

                    admin_p = cur.fetchall()

                    if admin_p[0][0] == str(upassword):
                        print("SUCCESS")
                        
                        cur.execute('select AdminFirstName, AdminLastName, AdminID, DepartmentName from Admin, Department where AdminEmail = %s and DepartmentID = Admin_Department', (uemail,))

                        admin_info = cur.fetchall()
                        print(admin_info)

                        #sessions
                        session['admin_id'] = admin_info[0][2]
                        session['admin_fname'] = admin_info[0][0]
                        session['admin_lname'] = admin_info[0][1]
                        session['admin_department'] = admin_info[0][3]
                        session['admin_email'] = uemail
                        session['user_type'] = "Admin"
                        
                        return redirect('/dashboard')
                    else:
                        print('FAIL')
                        return render_template('login.html', message = "Incorrect password")
                else:
                    print('FAIL')
                    return render_template('login.html', message = "Incorrect email")

        else:
            return render_template('login.html')
    except:
        return redirect('/login')

@app.route('/logout')
def logout():
    try:

        # clear session
        if session['user_type'] == "Admin":
            session.pop('admin_id')
            session.pop('admin_fname')
            session.pop('admin_lname')
            session.pop('admin_department')
            session.pop('admin_email')

        elif session['user_type'] == "Student":
            session.pop('student_id')
            session.pop('student_fname') 
            session.pop('student_lname')
            session.pop('student_program')
            session.pop('student_email')
            session.pop('student_batch')
        
        session.pop('user_type')

        return redirect('/')
    except:
        return redirect('/login')