from flask import render_template,redirect,session,request, flash
from flask_app import app
from flask_app.models.appointment import Appointment
from flask_app.models.user import User
from datetime import datetime, timedelta 
import time

@app.route('/new/appointment')
def new_appoinment():
    if 'users_id' not in session:
        return redirect('/logout')
    data = {
        "id":session['users_id']
    }
    return render_template('new_appointment.html',user=User.get_by_id(data))


@app.route('/create/appointment',methods=['POST'])
def create_appointment():
    if 'users_id' not in session:
        return redirect('/logout')
    if not Appointment.validate_appointments(request.form):
        return redirect('/new/appointment')
    data = {
        "task": request.form["task"],
        "date": request.form["date"],
        "status": request.form["status"],
        "users_id": session["users_id"]
    }
    Appointment.save(data)
    return redirect('/dashboard')

@app.route('/edit/appointment/<int:id>')
def edit_appointment(id):
    if 'users_id' not in session:
        return redirect('/logout')
    data = {
        "id":id
    }
    user_data = {
        "id":session['users_id']
    }
    return render_template("edit_appointment.html",edit=Appointment.get_one(data),user=User.get_by_id(user_data))

@app.route('/update/appointment',methods=['POST'])
def update_appointment():
    if 'users_id' not in session:
        return redirect('/logout')
    if not Appointment.validate_appointments(request.form):
        return redirect('/new/Appointment')
    Appointment.update(request.form)
    return redirect('/dashboard')

@app.route('/appointment/<int:id>')
def show_appointment(id):
    if 'users_id' not in session:
        return redirect('/logout')
    data = {
        "id":id
    }
    user_data = {
        "id":session['users_id']
    }
    return render_template("show_appointment.html",appointment=Appointment.get_one(data),user=User.get_by_id(user_data))

@app.route('/destroy/appointment/<int:id>')
def destroy_appointment(id):
    if 'users_id' not in session:
        return redirect('/logout')
    data = {
        "id":id
    }
    Appointment.destroy(data)
    return redirect('/dashboard')