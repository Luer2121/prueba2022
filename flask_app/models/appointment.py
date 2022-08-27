from flask_app.config.bd import connectToMySQL
from flask import flash
from datetime import datetime, timedelta
import time

class Appointment:
    db_name = 'prueba2020'

    def __init__(self,db_data):
        self.id = db_data['id']
        self.task = db_data['task']
        self.date = db_data['date']
        self.status = db_data['status']
        self.users_id = db_data['users_id']
        self.created_at = db_data['created_at']
        self.updated_at = db_data['updated_at']
        self.hoy = datetime.now()

    @classmethod
    def save(cls,data):
        query = "INSERT INTO appointments (task, date, status, users_id) VALUES (%(task)s,%(date)s,%(status)s,%(users_id)s);"
        return connectToMySQL(cls.db_name).query_db(query, data)

    @classmethod
    def get_all(cls):
        query = "SELECT * FROM appointments WHERE date >= NOW();"
        results =  connectToMySQL(cls.db_name).query_db(query)
        all_appointments = []
        for row in results:
            all_appointments.append( cls(row) )
        return all_appointments
    
    @classmethod
    def get_all2(cls):
        query = "SELECT * FROM appointments WHERE date < NOW();"
        results =  connectToMySQL(cls.db_name).query_db(query)
        all_appointments2 = []
        for row in results:
            all_appointments2.append( cls(row) )
        return all_appointments2

    @classmethod
    def get_one(cls,data):
        query = "SELECT * FROM appointments WHERE id = %(id)s;"
        results = connectToMySQL(cls.db_name).query_db(query,data)
        return cls( results[0] )

    @classmethod

    def update(cls, data):
        query = "UPDATE appointments SET task=%(task)s, date=%(date)s, status=%(status)s,updated_at=NOW() WHERE id = %(id)s;"
        return connectToMySQL(cls.db_name).query_db(query,data)
    
    @classmethod
    def destroy(cls,data):
        query = "DELETE FROM appointments WHERE id = %(id)s;"
        return connectToMySQL(cls.db_name).query_db(query,data)

    @staticmethod
    def validate_appointments(appointment):
        is_valid = True
        if len(appointment['task']) < 3:
            is_valid = False
            flash("Name must be at least 3 characters","appointment")
        return is_valid