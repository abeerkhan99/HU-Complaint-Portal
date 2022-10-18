from flask import Flask, render_template, url_for, request, session, redirect
import psycopg2

# app instance
app = Flask(__name__, template_folder='Template')
# for sessions
app.secret_key = 'BAD_SECRET_KEY'

def get_db_connection():
    conn = psycopg2.connect(
            host="localhost",
            database="hu-complaint-portal",
            user= 'postgres',
            password= '12345')
    
    print("YES")
    return conn

# Open a cursor to perform database operations
conn = get_db_connection()
cur = conn.cursor()

# routing
@app.route('/')
def home():

    cur.execute('select count(ComplaintID) from Complaint')
    total = cur.fetchall()

    cur.execute('select count(ComplaintID) from Complaint, Status where Complaint_Status = StatusID and StatusName = %s', ('Pending',))
    pending = cur.fetchall()

    cur.execute('select count(ComplaintID) from Complaint, Status where Complaint_Status = StatusID and StatusName = %s', ('Resolved',))
    resolved = cur.fetchall()
    
    return render_template('welcome.html', total = total[0][0], pending = pending[0][0], resolved = resolved[0][0])

import login
import register
import reset
import student_complaint
import admin_complaint
import edit_account
import dashboard