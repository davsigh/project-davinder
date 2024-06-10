import os

class Config:
    SECRET_KEY = os.urandom(24)
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://username:password@db_server_ip/ecommerce'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
