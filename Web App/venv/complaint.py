from re import T
from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur
import datetime

@app.route('/view-complaint')
def view_complaint():
    if session['user_type'] == "Admin":

        # remove data from session
        try:
            session.pop('a_number')
            session.pop('a_date')
            session.pop('a_department')
            session.pop('a_status')
            session.pop('a_title')
            session.pop('a_content')
        except:
            pass

        cur.execute('select ComplaintID, ComplaintDate, DepartmentName, StatusName, ComplaintTitle, ComplaintContent from Complaint, Department, Status where Complaint_DepartmentID = DepartmentID and Complaint_Status = StatusID and DepartmentName = %s', (session['admin_department'],))
        complaint_list = cur.fetchall()

        return render_template('admin-view-complaint.html', complaint_list = complaint_list, len_list = len(complaint_list))

    elif session['user_type'] == "Student":

        # remove data from session
        try:
            session.pop('number')
            session.pop('date')
            session.pop('department')
            session.pop('status')
            session.pop('title')
            session.pop('content')
        except:
            pass

        cur.execute('select * from Complaint, Department, Status where Complaint_Status = StatusID and Complaint_DepartmentID = DepartmentID and Complaint_StudentID = %s', (session['student_id'],))
        complaint_list = cur.fetchall()

        return render_template('student-view-complaint.html', complaint_list = complaint_list, len_list = len(complaint_list))
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


@app.route('/edit-complaint/<number>%<date>%<dept>-<status>-<title>-<content>')
def edit_complaint(number, date, dept, status, title, content):
    # only unresolved complaints can be edited by the student who lodged the complaint
    if session['user_type'] == "Student":
        
        cur.execute('select DepartmentName from Department')
        department = cur.fetchall()

        session['number'] = number
        session['date'] = date
        session['department'] = dept
        session['status'] = status
        session['title'] = title
        session['content'] = content

        return render_template('edit-complaint.html', department = department, number = number, date = date, dept = dept, status = status, title = title, content = content)

    else:
        return redirect('/login')

@app.route('/edit-complaint-submit', methods = ['GET', 'POST'])
def edit_complaint_submit():
    if session['user_type'] == "Student":

        cur.execute('select DepartmentName from Department')
        departmentname = cur.fetchall()

        new_c_title = request.form['c_title']
        new_c_content = request.form['c_content']
        new_c_department = request.form.get('department')

        # check if this complaint information exists in the database
        cur.execute('select ComplaintTitle, ComplaintContent from Complaint where (ComplaintTitle = %s or ComplaintContent = %s)', (new_c_title, new_c_content,))
        complaint_exists = cur.fetchall()

        if len(complaint_exists) == 0:
            # update complaint in database

            cur.execute('select DepartmentID from Department where DepartmentName = %s', (new_c_department,))
            new_dept = cur.fetchall()

            cur.execute("UPDATE Complaint SET ComplaintTitle = %s, ComplaintContent = %s, Complaint_DepartmentID = %s WHERE ComplaintID = %s and ComplaintDate = %s and ComplaintTitle = %s and ComplaintContent = %s",
            (new_c_title, new_c_content, new_dept[0][0], session['number'], session['date'], session['title'], session['content']))

            conn.commit()

            return render_template('edit-complaint.html', message = "Details updated successfully! Would you like to go back?", department = departmentname, number = session['number'], date = session['date'], dept = session['department'], status = session['status'], title = session['title'], content = session['content'])

        else:
            return render_template('edit-complaint.html', message = "A complaint with similar details aleady exists.", department = departmentname, number = session['number'], date = session['date'], dept = session['department'], status = session['status'], title = session['title'], content = session['content'])

    else:
        return redirect('/login')

@app.route('/reassign-complaint/<number>%<date>%<dept>-<status>-<title>-<content>')
def reassign_complaint(number, date, dept, status, title, content):
    if session['user_type'] == "Admin":

        cur.execute('select DepartmentName from Department')
        department = cur.fetchall()
        
        session['a_number'] = number
        session['a_date'] = date
        session['a_department'] = dept
        session['a_status'] = status
        session['a_title'] = title
        session['a_content'] = content

        return render_template('assign-complaint.html', department = department, number = number, date = date, dept = dept, status = status, title = title, content = content)

    else:
        return redirect('/login')

@app.route('/reassign-complaint-submit', methods = ['GET', 'POST'])
def reassign_complaint_submit():
    if session['user_type'] == "Admin":
        new_department = request.form.get('department')
        if new_department == session['a_status']:
            return redirect('/view-complaint')
        else:
            # update field in database

            cur.execute('select DepartmentID from Department where DepartmentName = %s', (new_department,))
            new_dept_id = cur.fetchall()

            cur.execute('UPDATE Complaint SET Complaint_DepartmentID = %s  WHERE ComplaintID = %s and ComplaintDate = %s and ComplaintTitle = %s and ComplaintContent = %s and Complaint_DepartmentID = %s',
            (new_dept_id[0][0], session['a_number'], session['a_date'], session['a_title'], session['a_content'], session['a_department']))

            conn.commit()
            return redirect('/view-complaint')
    else:
        return redirect('/login')

@app.route('/resolve-complaint/<number>%<date>%<dept>-<status>-<title>-<content>')
def resolve_complaint(number, date, dept, status, title, content):
    if session['user_type'] == "Admin":

        # update complaint status and complaint admin id
        cur.execute('select DepartmentID from Department where DepartmentName = %s', (dept,))
        department_id = cur.fetchall()

        cur.execute('select StatusID from Status where StatusName = %s', ('Resolved',))
        new_status_id = cur.fetchall()

        cur.execute('UPDATE Complaint SET Complaint_Status = %s and Complaint_AdminID = %s  WHERE ComplaintID = %s and ComplaintDate = %s and ComplaintTitle = %s and ComplaintContent = %s and Complaint_DepartmentID = %s',
        (new_status_id[0][0], session['admin_id'], number, date, title, content, department_id[0][0]))

        conn.commit()

        return redirect('/view-complaint')

    else:
        return redirect('/login')

@app.route('/close-complaint/<number>%<date>%<dept>-<status>-<title>-<content>')
def close_complaint(number, date, dept, status, title, content):
    # a resolved complaint can be closed by a student
    # updates the complaint database by adding a resolvedate
    if session['user_type'] == "Student":

        cur.execute('select DepartmentID from Department where DepartmentName = %s', (dept,))
        department_id = cur.fetchall()

        cur.execute('UPDATE Complaint SET ResolveDate = %s WHERE ComplaintID = %s and ComplaintDate = %s and ComplaintTitle = %s and ComplaintContent = %s and Complaint_DepartmentID = %s',
        (datetime.date.today(), number, date, title, content, department_id[0][0]))

        conn.commit()

        return redirect('/view-complaint')

    else:
        return redirect('/login')

@app.route('/delete-complaint/<number>%<date>%<dept>-<status>-<title>-<content>')
def delete_complaint(number, date, dept, status, title, content):
    # only unresolved complaints can be deleted by the student who lodged the complaint
    if session['user_type'] == "Student":
        cur.execute('select DepartmentID from Department where DepartmentName = %s', (dept,))
        department_id = cur.fetchall()

        cur.execute('select StatusID from Status where StatusName = %s', (status,))
        status_id = cur.fetchall()

        cur.execute('delete from Complaint where ComplaintID = %s and ComplaintDate = %s and Complaint_DepartmentID = %s and Complaint_Status = %s and ComplaintTitle = %s and ComplaintContent = %s', (number, date, department_id[0][0], status_id[0][0], title, content))
        conn.commit()

        return redirect('/view-complaint')

    else:
        return redirect('/login')
