from flask import Flask, render_template, url_for, request, session, redirect
from app import app

@app.route('/view-profile')
def view_profile():
    return render_template('view-complaint.html')

@app.route('/edit-profile')
def edit_profile():
    return render_template('view-complaint.html')