# Tambahkan titik (.) sebelum database artinya "import dari folder yang sama"
from database_klinik import Base
from sqlalchemy import Column, Integer, String, Text, DateTime
from sqlalchemy.sql import func

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(100), unique=True, nullable=False)
    password = Column(String(255), nullable=False)
    nama = Column(String(100), nullable=False)
    role = Column(String(50), nullable=False)

class Antrian(Base):
    __tablename__ = "antrian"
    id = Column(Integer, primary_key=True, index=True)
    nama = Column(String(100), nullable=False)
    keluhan = Column(Text, nullable=True)
    usia = Column(Integer, nullable=True)
    jk = Column(String(20), nullable=True)
    diagnosa = Column(Text, nullable=True)
    resep_obat = Column(Text, nullable=True)
    dokter = Column(String(100), nullable=True)
    status = Column(String(50), default="Menunggu")
    created_at = Column(DateTime(timezone=True), server_default=func.now())

class VitalSign(Base):
    __tablename__ = "vital_sign"
    id = Column(Integer, primary_key=True, index=True)
    pasien_id = Column(String(50), nullable=False)
    tensi = Column(String(20), nullable=True)
    suhu = Column(String(20), nullable=True)
    nadi = Column(String(20), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())