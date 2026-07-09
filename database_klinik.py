from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
SQLALCHEMY_DATABASE_URL = "postgresql://neondb_owner:npg_MedcA1oj7RSi@ep-shiny-violet-aoskovsd-pooler.c-2.ap-southeast-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require"

# Membuat engine koneksi
engine = create_engine(SQLALCHEMY_DATABASE_URL)

# Membuat session untuk transaksi data
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base class untuk membuat model/tabel nanti
Base = declarative_base()

# Dependency untuk membuka dan menutup koneksi secara otomatis
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()