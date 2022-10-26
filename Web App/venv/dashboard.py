from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur

@app.route('/dashboard')
def dashboard():
    try:
        if session['user_type'] == "Admin":

            # get list of unresolved complaints for the admin department
            cur.execute('select count(ComplaintID) from Complaint, Department, Status where Complaint_DepartmentID = DepartmentID and Complaint_Status = StatusID and DepartmentName = %s and StatusName = %s', (session['admin_department'], 'Unresolved',))
            unresolved_object = cur.fetchall()

            # get list of resolved complaints for the admin department by admin id
            cur.execute('select count(ComplaintID) from Complaint, Department, Status where Complaint_DepartmentID = DepartmentID and Complaint_Status = StatusID and DepartmentName = %s and StatusName = %s', (session['admin_department'],'Resolved'))
            resolved_object = cur.fetchall()

            cur.execute('select count(ComplaintID) from Complaint, Department, Status where Complaint_DepartmentID = DepartmentID and Complaint_Status = StatusID and DepartmentName = %s and StatusName = %s', (session['admin_department'], 'Pending'))
            pending_object = cur.fetchall()

            cur.execute('select ComplaintTitle, ComplaintDate from Complaint, Department, Status where Complaint_DepartmentID = DepartmentID and Complaint_Status = StatusID and DepartmentName = %s and StatusName = %s', (session['admin_department'], 'Unresolved',))
            unresolved_title = cur.fetchall()

            return render_template('admin-dashboard.html', unresolved = unresolved_object[0][0], resolved = resolved_object[0][0], pending = pending_object[0][0], complaint_title = unresolved_title)

        elif session['user_type'] == "Student":

            # get list of unresolved complaints that the student lodged
            cur.execute('select count(ComplaintID) from Complaint, Student, Status where Complaint_StudentID = StudentID and Complaint_Status = StatusID and Complaint_StudentID = %s and StatusName = %s', (session['student_id'], 'Unresolved',))
            unresolved_object = cur.fetchall()

            # get list of resolved complaints that the student lodged
            cur.execute('select count(ComplaintID) from Complaint, Student, Status where Complaint_StudentID = StudentID and Complaint_Status = StatusID and Complaint_StudentID = %s and StatusName = %s', (session['student_id'], 'Resolved',))
            resolved_object = cur.fetchall()

            # get list of pending complaints that the student lodged
            cur.execute('select count(ComplaintID) from Complaint, Student, Status where Complaint_StudentID = StudentID and Complaint_Status = StatusID and Complaint_StudentID = %s and StatusName = %s', (session['student_id'], 'Pending',))
            pending_object = cur.fetchall()

            cur.execute('select ComplaintTitle, StatusName from Complaint, Student, Status where Complaint_StudentID = StudentID and Complaint_Status = StatusID and Complaint_StudentID = %s and (StatusName = %s or StatusName = %s)', (session['student_id'], 'Unresolved', 'Pending',))
            complaint_object = cur.fetchall()

            return render_template('student-dashboard.html', unresolved = unresolved_object[0][0], resolved = resolved_object[0][0], pending = pending_object[0][0], complaint = complaint_object)
        
        else:
            return redirect('/login')
    except:
        return redirect('/login')
        