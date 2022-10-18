from flask import Flask, render_template, url_for, request, session, redirect
from app import app
from app import conn, cur

@app.route('/view-complaints')
def view_complaint_admin():
    return render_template('view-complaint-admin.html')

@app.route('/reassign')
def reassign_complaint():
    return render_template('assign-complaint.html')

@app.route('/resolve')
def resolve_complaint():
    return render_template('complaint-detail.html')

@app.route('/change-status')
def change_status():
    return render_template('complaint-detail.html')