from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur
import datetime

@app.route('/view-complaint')
def view_complaint():
    if session['user_type'] == "Admin":

        cur.execute('select ComplaintTitle, ComplaintContent, DepartmentName, StatusName, ComplaintDate from Complaint, Department, Status where Complaint_DepartmentID = DepartmentID and Complaint_StatusID = StatusID and Complaint_DepartmentID = %s)', (session['admin_department'],))
        complaint_list = cur.fetchall()

        return render_template('admin-view-complaint.html', complaint_list = complaint_list)

    elif session['user_type'] == "Student":

        cur.execute('select ComplaintTitle, ComplaintContent, DepartmentName, StatusName, ComplaintDate from Complaint, Student, Department, Status where Complaint_DepartmentID = DepartmentID and Complaint_StudentID = StudentID and Complaint_StatusID = StatusID and Complaint_StudentID = %s)', (session['student_id'],))
        complaint_list = cur.fetchall()

        return render_template('student-view-complaint.html', complaint_list = complaint_list)
    else:
        return redirect('/login')

@app.route('/make-complaint', methods = ['GET', 'POST'])
def make_complaint():
    if session['user_type'] == "Student":
        
        cur.execute('select DepartmentName from Department')
        departmentname = cur.fetchall()

        return render_template('make-complaint.html', department = departmentname)
    else:
        return redirect('/login')

@app.route('/make-complaint-submit', methods = ['GET', 'POST'])
def make_complaint_submit():
    if session['user_type'] == "Student":
        if request.method == "POST":

            complaint_title = request.form['c_title']
            complaint_content = request.form['c_content']
            c_department = request.form.get('department')

            # check if complaint 
            cur.execute('select ComplaintTitle, ComplaintContent from Complaint, Student, Department where Complaint_DepartmentID = DepartmentID and DepartmentName = %s and Complaint_StudentID = StudentID and Complaint_StudentID = %s and (ComplaintTitle = %s or ComplaintContent = %s)', (c_department, session['student_id'], complaint_title, complaint_content,))
            complaint_exists = cur.fetchall()

            if len(complaint_exists) == 0:

                # add complaint in database
                cur.execute('select DepartmentID from Department where DepartmentName = %s', (c_department,))
                departmentid = cur.fetchall()

                cur.execute("insert into Complaint(ComplaintTitle, ComplaintContent, ComplaintDate, Complaint_DepartmentID, Complaint_StudentID, Complaint_Status) VALUES(%s,%s, %s, %s, %s, %s)", 
                            (complaint_title, complaint_content, datetime.date.today(), departmentid[0][0], session['student_id'], 1))
                
                conn.commit()

                cur.execute('select DepartmentName from Department')
                departmentname = cur.fetchall()

                return render_template('make-complaint.html', message = "Complaint lodged successfully! Would you like to file another one?", department = departmentname)
            
            else:
                cur.execute('select DepartmentName from Department')
                departmentname = cur.fetchall()

                return render_template('make-complaint.html', message = "A complaint with similar details has already been lodged.", department = departmentname)
            
        else:
            cur.execute('select DepartmentName from Department')
            departmentname = cur.fetchall()

            return render_template('make-complaint.html', department = departmentname)
    else:
        return redirect('/login')


@app.route('/edit-complaint')
def edit_complaint():
    # only unresolved complaints can be edited by the student who lodged the complaint
        return redirect('/login')

@app.route('/reassign-complaint')
def reassign_complaint():
        return redirect('/login')

@app.route('/resolve-complaint')
def resolve_complaint():
        return redirect('/login')

@app.route('/close-complaint')
def close_complaint():
        return redirect('/login')

@app.route('/delete-complaint')
def delete_complaint():
        return redirect('/login')
