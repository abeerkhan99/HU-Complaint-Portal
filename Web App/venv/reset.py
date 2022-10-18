from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur


@app.route('/reset')
def reset():
    return render_template('reset.html')


@app.route('/verify', methods = ['GET', 'POST'])
def verify():
    if request.method == 'POST':

        user_type = request.form['u_type']
        user_id = request.form['s_id']
        user_email = request.form['email']

        # check if user exists in database
        if user_type == "Admin":

            cur.execute('select AdminID, AdminEmail from Admin where AdminID = %s and AdminEmail = %s', (user_id, user_email,))
            admin_info = cur.fetchall()

            if len(admin_info) == 0:
                return render_template('reset.html', message = "There is no account associated with this email address and admin ID. Have you entered the correct information?")
            else:
                session['reset_userid'] = user_id
                session['reset_useremail'] = user_email
                session['reset_usertype'] = "Admin"
                return redirect('/reset-password')

        elif user_type == "Student":
            cur.execute('select StudentID, StudentEmail from Student where StudentID = %s and StudentEmail = %s', (user_id, user_email,))
            student_info = cur.fetchall()

            if len(student_info) == 0:
                return render_template('reset.html', message = "There is no account associated with this email address and student ID. Have you entered the correct information?")
            else:
                session['reset_userid'] = user_id
                session['reset_useremail'] = user_email
                session['reset_usertype'] = "Student"
                return redirect('/reset-password')

    else:
        return render_template('reset.html')

@app.route('/reset-password', methods = ['GET', 'POST'])
def reset_password():
    return render_template('reset-pass.html')
        
@app.route('/reset-pass', methods = ['GET', 'POST'])
def reset_pass():
    if session['reset_usertype'] == "Admin" or session['reset_usertype'] == "Student":

        if request.method == 'POST':

            u_password = request.form['password']

            if session['reset_usertype'] == "Admin":
                cur.execute('update Admin set AdminPassword = %s where AdminID = %s and AdminEmail = %s', 
                            (u_password, session['reset_userid'], session['reset_useremail'],))

                conn.commit()

                # clear session
                session.pop('reset_userid')
                session.pop('reset_useremail')
                session.pop('reset_usertype')

                return render_template('login.html', message = "Password has been changed! Please log in now.")

            elif session['reset_usertype'] == "Student":
                cur.execute('update Student set StudentPassword = %s where StudentID = %s and StudentEmail = %s', 
                            (u_password, session['reset_userid'], session['reset_useremail'],))

                conn.commit()

                # clear session
                session.pop('reset_userid')
                session.pop('reset_useremail')
                session.pop('reset_usertype')

                return render_template('login.html', message = "Password has been changed! Please log in now.")
        else:
            return render_template('reset-pass.html')
    else:
        return redirect('/reset')