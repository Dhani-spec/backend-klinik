from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import List, Optional
from database_klinik import engine, get_db
import models

# Inisialisasi Aplikasi
app = FastAPI(title="API Klinik Pintar")

# Middleware CORS (Wajib agar Flutter bisa panggil API tanpa terhalang keamanan)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Otomatis buat tabel jika belum ada
models.Base.metadata.create_all(bind=engine)


# ==========================================
# PYDANTIC SCHEMAS (Format Data Input/Output)
# ==========================================

class UserLogin(BaseModel):
    email: str
    password: str

class AntrianCreate(BaseModel):
    nama: str
    keluhan: Optional[str] = None
    usia: Optional[int] = None
    jk: Optional[str] = None

class AntrianPeriksa(BaseModel):
    diagnosa: Optional[str] = None
    resep_obat: Optional[str] = None
    dokter: Optional[str] = None
    status: Optional[str] = "Ke Apotek"

class VitalSignCreate(BaseModel):
    pasien_id: str
    tensi: Optional[str] = None
    suhu: Optional[str] = None
    nadi: Optional[str] = None


# ==========================================
# ENDPOINT API FOR FLUTTER FRONTEND
# ==========================================

@app.get("/")
def root():
    return {"message": "API Klinik Berhasil Jalan!"}

# 1. ENDPOINT LOGIN
@app.post("/api/login")
def login(payload: UserLogin, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(
        models.User.email == payload.email, 
        models.User.password == payload.password
    ).first()
    
    if not user:
        raise HTTPException(status_code=400, detail="Email atau Password salah!")
        
    return {
        "status": "success",
        "user": {
            "id": user.id,
            "email": user.email,
            "nama": user.nama,
            "role": user.role
        }
    }

# 2. ENDPOINT ANTRIAN PASIEN
@app.get("/api/antrian")
def get_antrian(db: Session = Depends(get_db)):
    return db.query(models.Antrian).all()

@app.post("/api/antrian")
def create_antrian(data: AntrianCreate, db: Session = Depends(get_db)):
    baru = models.Antrian(
        nama=data.nama,
        keluhan=data.keluhan,
        usia=data.usia,
        jk=data.jk,
        status="Menunggu"
    )
    db.add(baru)
    db.commit()
    db.refresh(baru)
    return baru

@app.put("/api/antrian/{antrian_id}/periksa")
def update_pemeriksaan(antrian_id: int, data: AntrianPeriksa, db: Session = Depends(get_db)):
    antrian = db.query(models.Antrian).filter(models.Antrian.id == antrian_id).first()
    if not antrian:
        raise HTTPException(status_code=404, detail="Data antrian tidak ditemukan")
    
    if data.diagnosa is not None:
        antrian.diagnosa = data.diagnosa
    if data.resep_obat is not None:
        antrian.resep_obat = data.resep_obat
    if data.dokter is not None:
        antrian.dokter = data.dokter
    if data.status is not None:
        antrian.status = data.status
        
    db.commit()
    db.refresh(antrian)
    return antrian

# 3. ENDPOINT VITAL SIGN (TTV)
@app.get("/api/vital-sign")
def get_vital_signs(db: Session = Depends(get_db)):
    return db.query(models.VitalSign).all()

@app.post("/api/vital-sign")
def create_vital_sign(data: VitalSignCreate, db: Session = Depends(get_db)):
    baru = models.VitalSign(
        pasien_id=data.pasien_id,
        tensi=data.tensi,
        suhu=data.suhu,
        nadi=data.nadi
    )
    db.add(baru)
    db.commit()
    db.refresh(baru)
    return baru