# 🤖 ChatGPT Prompt: Generate TechnoMart Synthetic Dataset

## 📋 **MAIN PROMPT**

```
I need you to generate realistic synthetic CSV datasets for a database migration project. The client is "TechnoMart Indonesia" - an electronics retailer with messy legacy data that needs cleaning and migration.

**IMPORTANT REQUIREMENTS:**
- Generate Indonesian-appropriate data (names, addresses, phone numbers)
- Include realistic data quality issues (duplicates, inconsistent formats, missing values)
- Use realistic Indonesian electronics retail data
- Include proper business relationships between tables
- Generate large datasets (10K-50K records per table)

Please generate 6 separate CSV files with the following specifications:
```

---

## 📊 **Dataset 1: customers_raw.csv (12,000 records)**

```
Generate a customers CSV with these columns and realistic data quality issues:

**Columns:**
customer_id,first_name,last_name,email,phone,address,city,province,postal_code,registration_date,birth_date,gender,source

**Data Requirements:**
- Customer IDs: CUST001 to CUST12000 (but include 200-300 duplicates)
- Names: Indonesian names (Budi, Siti, Ahmad, Rina, etc.) + some Western names
- Email: Mix of gmail.com, yahoo.com, outlook.com, company emails
- Phone: Indonesian formats (+62, 08, 0821, inconsistent formatting)
- Cities: Jakarta, Surabaya, Bandung, Medan, Semarang, Yogyakarta, Makassar, Palembang
- Provinces: DKI Jakarta, Jawa Timur, Jawa Barat, Sumatera Utara, etc.
- Registration dates: 2022-01-01 to 2024-08-16
- Birth dates: 1960-2006 (some missing ~5%)
- Gender: M/F (some empty ~2%)
- Source: Online, Store, Referral, Social Media

**Data Quality Issues to Include:**
- 200-300 duplicate customer_ids with slightly different info
- 5% missing birth_date
- 2% missing gender
- Inconsistent phone formats: +6281234567890, 08123456789, 0821-345-6789, (021) 1234567
- Some invalid emails: missing @, incomplete domains
- Mix upper/lower case in names
```

---

## 📊 **Dataset 2: products_raw.csv (5,500 records)**

```
Generate a products CSV for electronics retailer:

**Columns:**
product_id,product_name,sku,brand,category,subcategory,supplier_id,cost_price,selling_price,stock_qty,min_stock,max_stock,weight_kg,dimensions,description,status

**Data Requirements:**
- Product IDs: PROD001 to PROD5500
- Categories: Smartphone, Laptop, TV, Audio, Gaming, Camera, Appliance, Accessory, Monitor
- Brands: Apple, Samsung, Sony, LG, Dell, HP, Asus, Xiaomi, Oppo, Vivo, Canon, Nintendo, etc.
- SKUs: Brand prefix + model (IPH14PM256, SAMGALS23, etc.)
- Price range: 50,000 to 50,000,000 IDR
- Supplier IDs: SUP001 to SUP250
- Stock: 0 to 500 (some products with 0 stock)
- Status: Active, Discontinued, Out of Stock

**Include realistic products:**
- iPhone 14/15 variants, Samsung Galaxy series
- MacBook, Dell XPS, HP Pavilion, Asus ROG
- Sony/Samsung/LG TVs in various sizes
- AirPods, Sony headphones, JBL speakers
- PlayStation, Xbox, Nintendo Switch
- Canon/Sony cameras, DJI drones
- Home appliances: air purifiers, vacuums, rice cookers

**Data Issues:**
- Some duplicate product names with different SKUs
- Missing descriptions ~3%
- Some negative stock quantities (data entry errors)
- Selling price sometimes lower than cost price (error)
```

---

## 📊 **Dataset 3: suppliers_raw.csv (250 records)**

```
Generate suppliers CSV:

**Columns:**
supplier_id,company_name,contact_person,email,phone,address,city,country,payment_terms,rating

**Data Requirements:**
- Supplier IDs: SUP001 to SUP250
- Mix of: Official brand distributors, Local importers, Wholesale companies
- Companies: Apple Indonesia, Samsung Electronics, Sony Indonesia, PT Erajaya, PT Trikomsel, etc.
- Contact persons: Mix Indonesian + foreign names
- Addresses: Major Indonesian cities + some international (Singapore, Hong Kong, China)
- Payment terms: NET 30, NET 45, NET 60, COD, Advance Payment
- Rating: A+, A, A-, B+, B, B-, C+, C (weighted toward higher ratings)
- Countries: Indonesia (70%), Singapore (10%), Malaysia (5%), China (10%), Others (5%)
```

---

## 📊 **Dataset 4: orders_raw.csv (45,000 records)**

```
Generate orders CSV with realistic Indonesian e-commerce patterns:

**Columns:**
order_id,customer_id,order_date,status,payment_method,shipping_address,shipping_cost,discount_amount,tax_amount,total_amount,notes

**Data Requirements:**
- Order IDs: ORD001 to ORD45000
- Customer IDs: Reference customers_raw (CUST001-CUST12000)
- Order dates: 2023-01-01 to 2024-08-16 (higher volume in recent months)
- Status: Completed (70%), Processing (10%), Shipped (15%), Cancelled (5%)
- Payment: Credit Card (40%), Bank Transfer (30%), E-Wallet (20%), COD (10%)
- Shipping cost: 25,000-100,000 IDR (based on distance/weight)
- Total amount: 100,000 to 100,000,000 IDR
- Tax: 11% of subtotal (PPN Indonesia)

**Business Logic:**
- Peak sales during: Ramadan, Back-to-school (July-August), Year-end
- Higher order values on weekends
- More COD in smaller cities
- Some customers with multiple orders (VIP behavior)
- Include some orders with 0 total (cancelled orders)
```

---

## 📊 **Dataset 5: order_items_raw.csv (120,000 records)**

```
Generate order items CSV (multiple items per order):

**Columns:**
order_item_id,order_id,product_id,quantity,unit_price,discount_percent,subtotal

**Data Requirements:**
- Order Item IDs: OI001 to OI120000
- Order IDs: Reference orders_raw
- Product IDs: Reference products_raw
- Quantity: 1-10 (mostly 1-2, occasionally bulk orders)
- Unit price: Should match product selling_price (with some variations for promotions)
- Discount: 0-25% (higher discounts for bulk orders)

**Business Patterns:**
- Average 2.7 items per order
- Smartphones often bought with accessories (cases, chargers)
- Laptops often bought with mice, bags
- Gaming consoles with extra controllers, games
- Some bundle deals (iPhone + AirPods with discount)
```

---

## 📊 **Dataset 6: inventory_movements.csv (80,000 records)**

```
Generate inventory movements for stock tracking:

**Columns:**
movement_id,product_id,movement_type,quantity,reference_id,movement_date,notes,user_id

**Data Requirements:**
- Movement IDs: MOV001 to MOV80000
- Product IDs: Reference products_raw
- Movement types: Stock In, Sale, Return, Adjustment, Transfer, Damage
- Quantity: Positive for inbound, negative for outbound
- Reference IDs: Purchase orders (PO001-PO5000), Order IDs, Adjustment IDs (ADJ001-ADJ500)
- Movement dates: 2023-01-01 to 2024-08-16
- User IDs: USR001 to USR50 (warehouse staff, sales staff)

**Patterns:**
- Regular stock replenishment (weekly/monthly)
- Sales movements matching order_items
- Periodic adjustments for inventory counts
- Returns for defective products
- Damage adjustments for fragile items
```

---

## 🎯 **GENERATION INSTRUCTIONS**

```
For each dataset:

1. **Start with the header row**
2. **Generate in batches** (ChatGPT has token limits, so generate 1000-2000 rows at a time)
3. **Maintain data consistency** across related tables
4. **Include realistic Indonesian context** (names, addresses, business patterns)
5. **Add specified data quality issues** 
6. **Use proper date formats** (YYYY-MM-DD HH:MM:SS for datetime, YYYY-MM-DD for date)
7. **Include realistic business relationships** (customers buying related products)

**Output format:**
- Pure CSV format
- No additional explanations
- Each row on a new line
- Use commas as separators
- Quote strings containing commas

**Start with customers_raw.csv first, then generate the others in order.**

```
---

Mantap! Di bawah ini aku kasih **kode Python siap tempel di Google Colab**—dibagi per sel (dataset) biar kamu bisa langsung **generate** dan **download** masing-masing CSV. Jalankan **berurutan dari atas ke bawah** supaya relasi antartabel tetap konsisten.

---

### 🔧 0) Setup & Helper Functions (jalankan dulu)

```python
#@title Setup & Helpers
import numpy as np
import pandas as pd
import random
from datetime import datetime, timedelta
import math, os

# Untuk download file di Colab
from google.colab import files

# Seed biar reproducible
RNG_SEED = 20250816
rng = np.random.default_rng(RNG_SEED)
random.seed(RNG_SEED)

# ---------- Helpers ----------
def random_date(start, end, _rng=None):
    _rng = _rng or rng
    delta = end - start
    sec = int(_rng.integers(0, int(delta.total_seconds()) + 1))
    return start + timedelta(seconds=sec)

def random_date_weighted_periods(periods, _rng=None):
    _rng = _rng or rng
    weights = np.array([p[2] for p in periods], dtype=float)
    weights = weights / weights.sum()
    idx = int(_rng.choice(len(periods), p=weights))
    start, end, _ = periods[idx]
    return random_date(start, end, _rng)

def choice_w(weights_dict, _rng=None):
    _rng = _rng or rng
    keys = list(weights_dict.keys())
    weights = np.array(list(weights_dict.values()), dtype=float)
    weights = weights / weights.sum()
    return _rng.choice(keys, p=weights)

def make_email(name, _rng=None):
    _rng = _rng or rng
    domains = ["gmail.com","yahoo.com","outlook.com","hotmail.com","icloud.com",
               "technomart.co.id","erajaya.co.id","trikomsel.co.id","indosat.com","telkomsel.co.id"]
    name = name.lower().replace(" ", ".")
    suffix = "" if _rng.random() < 0.8 else str(int(_rng.integers(1,9999)))
    return f"{name}{suffix}@{_rng.choice(domains)}"

def corrupt_email(email, _rng=None):
    _rng = _rng or rng
    modes = [
        lambda e: e.replace("@","",1),        # hilang '@'
        lambda e: e.split("@")[0],            # hilang domain
        lambda e: e.split("@")[0] + "@",      # domain kosong
        lambda e: e.replace(".", "", 1),      # titik pertama dihapus
        lambda e: e[:-1],                     # dipotong
    ]
    return _rng.choice(modes)(email)

def random_phone(_rng=None):
    _rng = _rng or rng
    patterns = [
        "+628{nine}",
        "08{nine}",
        "0821-{t3}-{t4}",
        "(021) {seven}",
        "+62 21 {seven}",
        "+62-8{nine}"
    ]
    nine = "".join(_rng.choice(list("0123456789")) for _ in range(int(_rng.integers(9,11))))
    t3 = "".join(_rng.choice(list("0123456789")) for _ in range(3))
    t4 = "".join(_rng.choice(list("0123456789")) for _ in range(4))
    seven = "".join(_rng.choice(list("0123456789")) for _ in range(7))
    pat = _rng.choice(patterns)
    return pat.format(nine=nine, t3=t3, t4=t4, seven=seven)

# Referensi geografis Indonesia
CITIES = ["Jakarta","Surabaya","Bandung","Medan","Semarang","Yogyakarta","Makassar","Palembang","Depok","Tangerang"]
PROVINCE_MAP = {
    "Jakarta":"DKI Jakarta","Depok":"Jawa Barat","Tangerang":"Banten","Surabaya":"Jawa Timur",
    "Bandung":"Jawa Barat","Medan":"Sumatera Utara","Semarang":"Jawa Tengah",
    "Yogyakarta":"DI Yogyakarta","Makassar":"Sulawesi Selatan","Palembang":"Sumatera Selatan"
}

# Nama khas Indonesia + Barat
FIRST_ID = ["Budi","Siti","Ahmad","Rina","Dewi","Agus","Putri","Rizky","Anisa","Andi","Yanto","Yanti","Sri","Wawan","Fajar","Tono","Tini","Rudi","Nadia","Hendra","Bagus","Dian","Lukman","Ayu","Sari","Novi","Bayu","Teguh","Yusuf","Nur","Herlina","Heri","Rahmat","Intan","Adit","Fikri","Rudianto","Yuli","Yuda","Mega"]
LAST_ID  = ["Santoso","Saputra","Nugroho","Wibowo","Pratama","Wijaya","Siregar","Hutabarat","Lubis","Simanjuntak","Putra","Putri","Hidayat","Anggraini","Kurniawan","Kusuma","Prasetyo","Maulana","Anwar","Fauzi","Ramadhan","Pambudi","Firmansyah","Yulianto","Sari","Setiawan","Permata","Lestari","Utami","Syahputra"]
FIRST_W  = ["Michael","Sarah","David","Emily","John","Jessica","Daniel","Emma","Robert","Olivia","William","Sophia"]
LAST_W   = ["Smith","Johnson","Williams","Brown","Jones","Garcia","Miller","Davis","Wilson","Anderson"]

# Path helper
def save_and_download(df, filename):
    df.to_csv(filename, index=False)
    files.download(filename)

print("Setup OK. Lanjut ke sel berikutnya ↑")
```

---

### 👤 1) customers\_raw\.csv (12,000 baris, dengan duplikasi & anomali)

```python
#@title Generate & Download customers_raw.csv
n_customers = 12000
dup_count = int(np.random.default_rng(RNG_SEED).integers(200,301))  # 200-300 dupe

sources = ["Online","Store","Referral","Social Media"]
genders = ["M","F"]

start_reg = datetime(2022,1,1)
end_reg   = datetime(2024,8,16,23,59,59)
start_birth = datetime(1960,1,1)
end_birth   = datetime(2006,12,31)

records = []
base_count = n_customers - dup_count
for i in range(1, base_count + 1):
    cust_id = f"CUST{i:05d}"
    if rng.random() < 0.18:
        fn = rng.choice(FIRST_W); ln = rng.choice(LAST_W)
    else:
        fn = rng.choice(FIRST_ID); ln = rng.choice(LAST_ID)
    # Casing acak
    if rng.random() < 0.1: fn = fn.upper()
    if rng.random() < 0.1: ln = ln.capitalize()

    fullname = f"{fn} {ln}"
    email = make_email(fullname)
    if rng.random() < 0.025:  # ~2.5% email invalid
        email = corrupt_email(email)
    phone = random_phone()
    city = rng.choice(CITIES)
    province = PROVINCE_MAP.get(city, "Jawa Barat")
    address = f"Jl. {rng.choice(['Merdeka','Sudirman','Thamrin','Gatot Subroto','Asia Afrika','Diponegoro','Ahmad Yani'])} No.{int(rng.integers(1,999))}"
    postal = f"{int(rng.integers(10110,99999))}"
    reg_date = random_date(start_reg, end_reg).strftime("%Y-%m-%d %H:%M:%S")
    birth = "" if rng.random() < 0.05 else random_date(start_birth, end_birth).strftime("%Y-%m-%d")  # ~5% kosong
    gender = "" if rng.random() < 0.02 else rng.choice(genders)  # ~2% kosong
    source = rng.choice(sources)

    records.append([cust_id, fn, ln, email, phone, address, city, province, postal, reg_date, birth, gender, source])

# Tambahkan duplikat dengan variasi kecil
dup_ids = rng.choice(range(1, base_count + 1), size=dup_count, replace=False)
for idx in dup_ids:
    original = records[idx-1].copy()
    if rng.random() < 0.6: original[4] = random_phone()
    if rng.random() < 0.5: original[3] = make_email(original[1] + " " + original[2])
    if rng.random() < 0.3: original[5] = f"Jl. {rng.choice(['Merdeka','Pahlawan','Veteran','Pemuda'])} No.{int(rng.integers(1,999))}"
    if rng.random() < 0.3: original[1] = original[1].lower().capitalize() if rng.random()<0.5 else original[1].upper()
    records.append(original)

rng.shuffle(records)
customers_df = pd.DataFrame(records[:n_customers], columns=[
    "customer_id","first_name","last_name","email","phone","address","city","province","postal_code",
    "registration_date","birth_date","gender","source"
])

save_and_download(customers_df, "customers_raw.csv")
```

---

### 🚚 2) suppliers\_raw\.csv (250 baris)

```python
#@title Generate & Download suppliers_raw.csv
n_suppliers = 250
supplier_ids = [f"SUP{i:03d}" for i in range(1, n_suppliers+1)]
companies_known = [
    "Apple Indonesia","Samsung Electronics Indonesia","Sony Indonesia","PT Erajaya",
    "PT Trikomsel","LG Electronics Indonesia","PT Datascrip","PT Synnex Metrodata",
    "PT Global Digital Niaga","PT Mitra Adiperkasa"
]
payment_terms_pool = ["NET 30","NET 45","NET 60","COD","Advance Payment"]
ratings_pool = ["A+","A","A-","B+","B","B-","C+","C"]
city_pool = ["Jakarta","Surabaya","Bandung","Medan","Semarang","Yogyakarta","Makassar","Batam","Tangerang","Bekasi","Singapore","Kuala Lumpur","Shenzhen","Hong Kong","Guangzhou"]

rows = []
for sid in supplier_ids:
    company = rng.choice(companies_known) if rng.random() < 0.25 else f"PT {rng.choice(['Prima','Sinar','Maju','Berjaya','Tekno','Digital','Sentosa','Nusantara'])} {rng.choice(['Abadi','Makmur','Sejahtera','Perkasa','Cemerlang'])}"
    contact = f"{rng.choice(FIRST_ID + FIRST_W)} {rng.choice(LAST_ID + LAST_W)}"
    email = make_email(contact)
    if rng.random() < 0.02:
        email = corrupt_email(email)
    phone = random_phone()
    city = rng.choice(city_pool)
    if city in ["Jakarta","Surabaya","Bandung","Medan","Semarang","Yogyakarta","Makassar","Batam","Tangerang","Bekasi"]:
        country = "Indonesia"
    elif city == "Singapore":
        country = "Singapore"
    elif city == "Kuala Lumpur":
        country = "Malaysia"
    elif city in ["Shenzhen","Guangzhou"]:
        country = "China"
    elif city == "Hong Kong":
        country = "Hong Kong"
    else:
        country = rng.choice(["Thailand","Vietnam","Japan","United Arab Emirates"])
    address = f"Jl. {rng.choice(['Industri','Teknologi','Perdagangan','Pabrik'])} No.{int(rng.integers(1,999))}"
    payment = rng.choice(payment_terms_pool, p=[0.35,0.25,0.2,0.1,0.1])
    rating = rng.choice(ratings_pool, p=[0.15,0.25,0.2,0.15,0.1,0.08,0.05,0.02])

    rows.append([sid, company, contact, email, phone, address, city, country, payment, rating])

suppliers_df = pd.DataFrame(rows, columns=["supplier_id","company_name","contact_person","email","phone","address","city","country","payment_terms","rating"])
save_and_download(suppliers_df, "suppliers_raw.csv")
```

---

### 📦 3) products\_raw\.csv (5,500 baris + anomali stok/harga)

```python
#@title Generate & Download products_raw.csv
n_products = 5500
product_ids = [f"PROD{i:03d}" for i in range(1, n_products+1)]
categories = [
    ("Smartphone", ["Android","iOS"]),
    ("Laptop", ["Ultrabook","Gaming","Business"]),
    ("TV", ["LED","OLED","QLED","4K"]),
    ("Audio", ["Headphones","Speakers","Earbuds","Soundbar"]),
    ("Gaming", ["Console","Accessory","Game"]),
    ("Camera", ["DSLR","Mirrorless","Action","Drone"]),
    ("Appliance", ["Air Purifier","Vacuum","Rice Cooker","Microwave"]),
    ("Accessory", ["Charger","Case","Cable","Power Bank","Mouse","Keyboard","Bag"]),
    ("Monitor", ["24-inch","27-inch","32-inch","Ultrawide"])
]
brands = ["Apple","Samsung","Sony","LG","Dell","HP","Asus","Acer","Xiaomi","Oppo","Vivo","Canon","Nikon","DJI","Nintendo","Microsoft","Philips","JBL","Razer","Logitech","Lenovo","Panasonic","TCL"]
supplier_ids = [f"SUP{i:03d}" for i in range(1, 250+1)]

def sku_for(brand, _rng=None):
    _rng = _rng or rng
    prefix = "".join([c for c in brand if c.isalpha()][:3]).upper()
    model = "".join(_rng.choice(list("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")) for _ in range(int(_rng.integers(4,8))))
    return f"{prefix}{model}"

name_bits_map = {
    "Smartphone": lambda b: f"{b} {rng.choice(['Galaxy S23','Galaxy S24','A54','A34','iPhone 14','iPhone 15','Redmi Note 12','Mi 13','Find X5','Vivo V29'])}",
    "Laptop":     lambda b: f"{b} {rng.choice(['MacBook Air M2','MacBook Pro M3','XPS 13','XPS 15','Pavilion 14','ROG Strix','ZenBook 14','ThinkPad X1','IdeaPad 5'])}",
    "TV":         lambda b: f"{b} {rng.choice(['OLED','QLED','LED'])} {rng.choice(['43','50','55','65','75'])}\" 4K",
    "Audio":      lambda b: f"{b} {rng.choice(['Headphones','Earbuds','Soundbar','Bluetooth Speaker'])}",
    "Gaming":     lambda b: rng.choice(['PlayStation 5','Xbox Series X','Nintendo Switch','DualSense Controller','Joy-Con Pair','Game Pass 12M']),
    "Camera":     lambda b: f"{b} {rng.choice(['EOS R10','EOS R5','Z6 II','A7 IV','Action 3','Mavic Air 2'])}",
    "Appliance":  lambda b: f"{b} {rng.choice(['Air Purifier','Vacuum Cleaner','Rice Cooker','Microwave Oven'])}",
    "Accessory":  lambda b: f"{b} {rng.choice(['USB-C Charger','Lightning Cable','Phone Case','Power Bank','Wireless Mouse','Keyboard','Laptop Bag'])}",
    "Monitor":    lambda b: f"{b} {rng.choice(['24','27','32','34'])}\" {rng.choice(['FHD','QHD','4K','Ultrawide'])} Monitor"
}

rows = []
for pid in product_ids:
    cat, subcats = categories[int(rng.integers(0, len(categories)))]
    sub = rng.choice(subcats)
    brand = rng.choice(brands)
    pname = name_bits_map[cat](brand)
    sku = sku_for(brand)
    supplier_id = rng.choice(supplier_ids)
    cost_price = int(rng.integers(50_000, 50_000_000))
    # sesekali salah harga jual < harga pokok
    if rng.random() < 0.06:
        selling_price = max(10_000, int(cost_price * rng.uniform(0.6, 0.99)))
    else:
        selling_price = int(cost_price * rng.uniform(1.05, 1.6))
    stock_qty = int(rng.integers(-5, 501))   # termasuk negatif (error)
    min_stock = int(max(0, rng.normal(10, 5)))
    max_stock = int(min_stock + rng.integers(20, 200))
    weight_kg = round(max(0.1, rng.normal(1.2 if cat!="TV" else 12.0, 0.5 if cat!="TV" else 3.0)), 2)
    dimensions = f"{int(rng.integers(5,80))}x{int(rng.integers(5,80))}x{int(rng.integers(1,30))} cm"
    desc = "" if rng.random() < 0.03 else f"{pname} - {sub} category. Resmi garansi distributor."
    status = rng.choice(["Active","Discontinued","Out of Stock"], p=[0.75,0.1,0.15])

    rows.append([pid, pname, sku, brand, cat, sub, supplier_id, cost_price, selling_price, stock_qty, min_stock, max_stock, weight_kg, dimensions, desc, status])

products_df = pd.DataFrame(rows, columns=["product_id","product_name","sku","brand","category","subcategory","supplier_id","cost_price","selling_price","stock_qty","min_stock","max_stock","weight_kg","dimensions","description","status"])
save_and_download(products_df, "products_raw.csv")
```

---

### 🧾 4) orders\_raw\.csv (45,000 baris, pola musiman & pembayaran)

```python
#@title Generate & Download orders_raw.csv  (butuh customers_raw.csv)
assert os.path.exists("customers_raw.csv"), "Jalankan sel customers dulu!"
customers_df = pd.read_csv("customers_raw.csv")

n_orders = 45000
order_ids = [f"ORD{i:05d}" for i in range(1, n_orders+1)]

# Periode dengan bobot (Ramadan, Back-to-school, Year-end)
periods = [
    (datetime(2023,1,1), datetime(2023,3,22), 1.0),
    (datetime(2023,3,23), datetime(2023,4,21), 2.3),
    (datetime(2023,7,1),  datetime(2023,8,31), 1.6),
    (datetime(2023,11,1), datetime(2023,12,31,23,59,59), 1.8),
    (datetime(2024,1,1),  datetime(2024,3,10), 1.2),
    (datetime(2024,3,11), datetime(2024,4,9), 2.8),
    (datetime(2024,7,1),  datetime(2024,8,16,23,59,59), 1.7),
    (datetime(2023,5,1),  datetime(2023,6,30), 1.0),
    (datetime(2024,5,1),  datetime(2024,6,30), 1.0),
]

status_weights = {"Completed":0.70, "Processing":0.10, "Shipped":0.15, "Cancelled":0.05}
pay_weights    = {"Credit Card":0.40, "Bank Transfer":0.30, "E-Wallet":0.20, "COD":0.10}
small_cities = ["Yogyakarta","Makassar","Palembang","Semarang","Depok","Tangerang","Bandung","Medan"]

rows = []
order_customer_map = {}
for oid in order_ids:
    # refer ke ID pelanggan base (tanpa dupe)
    cust_num = int(rng.integers(1, (customers_df["customer_id"].str[4:].astype(int).max() - (len(customers_df) - customers_df["customer_id"].nunique())) + 1))
    cust_id = f"CUST{cust_num:05d}"

    order_date = random_date_weighted_periods(periods)
    status = choice_w(status_weights)
    payment = choice_w(pay_weights)

    ship_city = rng.choice(CITIES)
    if ship_city in small_cities and rng.random() < 0.25:
        payment = "COD"  # lebih banyak COD di kota lebih kecil
    ship_addr = f"Jl. {rng.choice(['Melati','Kenanga','Anggrek','Flamboyan','Mawar'])} No.{int(rng.integers(1,999))}, {ship_city}"
    shipping_cost = int(rng.integers(25_000,100_001) / 1000) * 1000
    order_discount = int(rng.integers(0, 2_000_001) / 1000) * 1000 if rng.random() < 0.3 else 0

    rows.append([oid, cust_id, order_date.strftime("%Y-%m-%d %H:%M:%S"), status, payment, ship_addr, shipping_cost, order_discount, 0, 0, ""])
    order_customer_map[oid] = (cust_id, order_date)

orders_df = pd.DataFrame(rows, columns=["order_id","customer_id","order_date","status","payment_method","shipping_address","shipping_cost","discount_amount","tax_amount","total_amount","notes"])
save_and_download(orders_df, "orders_raw.csv")
```

---

### 🧰 5) order\_items\_raw\.csv (120,000 baris) + update tax & total di orders

```python
#@title Generate & Download order_items_raw.csv (butuh products_raw.csv & orders_raw.csv) + update orders
assert os.path.exists("products_raw.csv"), "Jalankan sel products dulu!"
assert os.path.exists("orders_raw.csv"),   "Jalankan sel orders dulu!"

products_df = pd.read_csv("products_raw.csv")
orders_df   = pd.read_csv("orders_raw.csv")

# Siapkan mapping produk per kategori (biar cepat)
prod_by_cat = {cat: grp[["product_id","selling_price"]].to_numpy()
               for cat, grp in products_df.groupby("category")}
categories = np.array(list(prod_by_cat.keys()))

order_ids = orders_df["order_id"].to_numpy()
order_dates = pd.to_datetime(orders_df["order_date"]).to_numpy()

# Tentukan jumlah item per order (avg ~2.5-2.7) total 120k
n_orders = len(order_ids)
target_items = 120000
lam = 2.5
counts = rng.poisson(lam, size=n_orders)
counts = np.clip(counts, 1, 10)

diff = target_items - counts.sum()
idxs = np.arange(n_orders); rng.shuffle(idxs); j = 0
while diff != 0 and j < len(idxs)*5:
    i = idxs[j % len(idxs)]
    if diff > 0 and counts[i] < 10:
        counts[i] += 1; diff -= 1
    elif diff < 0 and counts[i] > 1:
        counts[i] -= 1; diff += 1
    j += 1

order_ids_items  = np.repeat(order_ids, counts)
order_dates_items= np.repeat(order_dates, counts)

# Sampling kategori & produk per item
cat_idx = rng.integers(0, len(categories), size=target_items)
cats_for_items = categories[cat_idx]

product_ids = np.empty(target_items, dtype=object)
unit_prices_base = np.empty(target_items, dtype=np.int64)
for cat in categories:
    mask = (cats_for_items == cat)
    n = int(mask.sum())
    if n == 0: continue
    arr = prod_by_cat[cat]
    choice_idx = rng.integers(0, len(arr), size=n)
    product_ids[mask] = arr[choice_idx, 0]
    unit_prices_base[mask] = arr[choice_idx, 1].astype(np.int64)

# Kuantitas & diskon
qty_choices = np.array([1,2,3,4,5,6,7,8,9,10])
qty_probs = np.array([0.55,0.25,0.07,0.04,0.03,0.02,0.015,0.01,0.007,0.003], dtype=float)
qty_probs = qty_probs / qty_probs.sum()

quantities = rng.choice(qty_choices, size=target_items, p=qty_probs)
base_disc = rng.uniform(0, 0.12, size=target_items)
bulk_bonus = np.where(quantities <= 2, 0.0, np.minimum(0.25, 0.02*(quantities-2)))
discount_percent = np.round(np.minimum(0.25, base_disc + bulk_bonus), 2)

# Weekend multiplier
weekend_mult = np.where(pd.Series(order_dates_items).dt.weekday.to_numpy() >= 5, 1.10, 1.0)
unit_price = (unit_prices_base * rng.uniform(0.95, 1.05, size=target_items) * weekend_mult).astype(int)

subtotal = (quantities * unit_price * (1.0 - discount_percent)).round().astype(int)

# Build DF
order_item_ids = np.array([f"OI{i:06d}" for i in range(1, target_items+1)], dtype=object)
order_items_df = pd.DataFrame({
    "order_item_id": order_item_ids,
    "order_id": order_ids_items,
    "product_id": product_ids,
    "quantity": quantities,
    "unit_price": unit_price,
    "discount_percent": discount_percent,
    "subtotal": subtotal
})

# Hitung subtotal per order, tax (11%), total (dengan shipping & order-level discount), 0 jika Cancelled
order_subtotals = order_items_df.groupby("order_id")["subtotal"].sum()
tax_rate = 0.11
orders_df["tax_amount"] = orders_df["order_id"].map(lambda oid: int(round(order_subtotals.get(oid,0)*tax_rate)))
orders_df["total_amount"] = orders_df.apply(
    lambda r: 0 if r["status"]=="Cancelled" else max(0, int(order_subtotals.get(r["order_id"],0) + round(order_subtotals.get(r["order_id"],0)*tax_rate) + int(r["shipping_cost"]) - int(r["discount_amount"]))),
    axis=1
)
orders_df.loc[orders_df["status"]=="Cancelled", ["tax_amount","total_amount"]] = 0

# Save & download
order_items_df.to_csv("order_items_raw.csv", index=False)
orders_df.to_csv("orders_raw.csv", index=False)  # overwrite dengan tax/total terisi

files.download("order_items_raw.csv")
files.download("orders_raw.csv")
```

---

### 🏷️ 6) inventory\_movements.csv (80,000 baris, sinkron dengan penjualan/retur)

```python
#@title Generate & Download inventory_movements.csv (butuh products_raw, orders_raw, order_items_raw)
assert os.path.exists("products_raw.csv"),      "Jalankan sel products dulu!"
assert os.path.exists("orders_raw.csv"),        "Jalankan sel orders + order items dulu!"
assert os.path.exists("order_items_raw.csv"),   "Jalankan sel order items dulu!"

products_df      = pd.read_csv("products_raw.csv")
orders_df        = pd.read_csv("orders_raw.csv")
order_items_df   = pd.read_csv("order_items_raw.csv")

n_mov = 80000
rows = []

# 1) Stock In (restock reguler)
stock_in_size = 30000
prod_ids_all = products_df["product_id"].to_numpy()
sel = rng.integers(0, len(prod_ids_all), size=stock_in_size)
dt_base = pd.to_datetime("2023-01-01")
dt_end  = pd.to_datetime("2024-08-16 23:59:59")
seconds_range = int((dt_end - dt_base).total_seconds())
dates_in = [(dt_base + timedelta(seconds=int(rng.integers(0, seconds_range)))) for _ in range(stock_in_size)]
rows.extend([[None, prod_ids_all[i], "Stock In", int(rng.integers(10,200)), f"PO{int(rng.integers(1,5001)):03d}", d.strftime("%Y-%m-%d %H:%M:%S"), "Restock", f"USR{int(rng.integers(1,51)):03d}"] for i, d in zip(sel, dates_in)])

# 2) Sales (subset dari order_items)
sale_idx = rng.choice(len(order_items_df), size=35000, replace=False)
sale_items = order_items_df.iloc[sale_idx]
sale_dates = pd.to_datetime(orders_df.set_index("order_id").loc[sale_items["order_id"], "order_date"]).to_numpy()
rows.extend([[None, pid, "Sale", -int(qty), oid, pd.to_datetime(dt).strftime("%Y-%m-%d %H:%M:%S"), "Auto from order", f"USR{int(rng.integers(1,51)):03d}"] 
             for pid, qty, oid, dt in zip(sale_items["product_id"], sale_items["quantity"], sale_items["order_id"], sale_dates)])

# 3) Returns (~3% dari items)
ret_idx = rng.choice(len(order_items_df), size=int(0.03*len(order_items_df)), replace=False)
ret_items = order_items_df.iloc[ret_idx]
ret_days = rng.integers(3,30, size=len(ret_items))
ret_dates = (pd.to_datetime(orders_df.set_index("order_id").loc[ret_items["order_id"], "order_date"]) + pd.to_timedelta(ret_days, unit="D")).dt.strftime("%Y-%m-%d %H:%M:%S").to_numpy()
ret_qty = np.maximum(1, np.floor(ret_items["quantity"].to_numpy() * rng.uniform(0.2,0.8, size=len(ret_items)))).astype(int)
rows.extend([[None, pid, "Return", int(q), oid, dt, "Customer return", f"USR{int(rng.integers(1,51)):03d}"]
             for pid, q, oid, dt in zip(ret_items["product_id"], ret_qty, ret_items["order_id"], ret_dates)])

# 4) Adjustment & Damage & Transfer untuk penuhi 80k
remaining = n_mov - len(rows)
adj_ct = int(remaining*0.6)
trf_ct = remaining - adj_ct

adj_sel = rng.integers(0, len(prod_ids_all), size=adj_ct)
adj_dates = [(dt_base + timedelta(seconds=int(rng.integers(0, seconds_range)))).strftime("%Y-%m-%d %H:%M:%S") for _ in range(adj_ct)]
for i, d in zip(adj_sel, adj_dates):
    qty = int(rng.integers(-5,6));  qty = qty if qty != 0 else 1
    t = "Damage" if (qty < 0 and rng.random() < 0.6) else "Adjustment"
    rows.append([None, prod_ids_all[i], t, qty, f"ADJ{int(rng.integers(1,501)):03d}", d, "Cycle count" if t=="Adjustment" else "Broken in transit", f"USR{int(rng.integers(1,51)):03d}"])

trf_sel = rng.integers(0, len(prod_ids_all), size=trf_ct)
trf_dates = [(dt_base + timedelta(seconds=int(rng.integers(0, seconds_range)))).strftime("%Y-%m-%d %H:%M:%S") for _ in range(trf_ct)]
for i, d in zip(trf_sel, trf_dates):
    qty = int(rng.integers(-50,51));  qty = 10 if qty == 0 else qty
    rows.append([None, prod_ids_all[i], "Transfer", qty, f"TRF{int(rng.integers(1,2001)):04d}", d, "Warehouse move", f"USR{int(rng.integers(1,51)):03d}"])

# Finalize & save
for idx in range(len(rows)):
    rows[idx][0] = f"MOV{idx+1:05d}"

inventory_df = pd.DataFrame(rows, columns=["movement_id","product_id","movement_type","quantity","reference_id","movement_date","notes","user_id"])
save_and_download(inventory_df, "inventory_movements.csv")
```

---

### 🎁 (Opsional) Sekaligus ZIP semua file & download satu kali

```python
#@title ZIP semua CSV dan download sekali klik
import shutil, glob

zip_name = "technomart_synthetic_datasets"
csvs = ["customers_raw.csv","products_raw.csv","suppliers_raw.csv","orders_raw.csv","order_items_raw.csv","inventory_movements.csv"]
missing = [f for f in csvs if not os.path.exists(f)]
assert not missing, f"File belum ada: {missing}. Jalankan sel-selnya dulu."

shutil.make_archive(zip_name, 'zip', '.', '.')  # zip seluruh folder kerja
files.download(f"{zip_name}.zip")
```

---

> Bisa jelaskan maksut yang dataset 5 : 🧰 5) order_items_raw.csv (120,000 baris) + update tax & total di orders
> kenapa ada dua dataset yang sekaligus di download ? dan kenapa ada perbedaan antara order raw di dataset 4 dan order rwa di dataset 5 ?

Great question! Singkatnya:

## Kenapa di langkah 5 ada **dua file** yang di-download?

Karena langkah 5 melakukan **dua hal sekaligus**:

1. **Membangun `order_items_raw.csv`** (120.000 baris) yang berisi rincian item per order.
2. **Menghitung ulang** nilai keuangan tiap order (subtotal → PPN 11% → total) **berdasarkan item** yang baru dibuat, lalu **menyimpan ulang `orders_raw.csv`** dengan kolom `tax_amount` dan `total_amount` yang sudah terisi.

Ini disengaja supaya setelah kamu punya item-itemnya, file orders langsung **konsisten** (tidak perlu langkah terpisah lagi untuk “update totals”). Jadi, dua file diunduh karena memang **keduanya baru final** setelah proses di langkah 5.

---

## Kenapa `orders_raw` di langkah 4 berbeda dengan `orders_raw` setelah langkah 5?

* **Langkah 4** hanya membuat “header” order: `order_id`, `customer_id`, `order_date`, `status`, `payment_method`, `shipping_address`, `shipping_cost`, `discount_amount`, **sementara `tax_amount` dan `total_amount` masih 0** (placeholder) karena **belum ada item** untuk dihitung.
* **Langkah 5** membuat `order_items_raw.csv`, lalu:

  * Hitung **subtotal per order** = Σ(`quantity` × `unit_price` × (1 − `discount_percent`)) dari semua item order itu.
  * Hitung **PPN 11%**: `tax_amount = round(0.11 × subtotal)`.
  * Hitung **total**:

    * Jika `status == "Cancelled"` → `tax_amount = 0`, `total_amount = 0`.
    * Jika bukan Cancelled → `total_amount = max(0, subtotal + tax_amount + shipping_cost − discount_amount)`.
  * Simpan ulang `orders_raw.csv` dengan **kolom pajak & total yang sudah terisi**.
* Dampaknya: **`orders_raw.csv` versi langkah 5 adalah versi final** (nilai keuangannya akurat). Versi langkah 4 memang “sementara”.

Catatan tambahan (yang bikin angka realistis):

* **Harga item** bisa sedikit berbeda dari harga katalog karena promo/variasi ±5% dan **weekend multiplier** (+10% di akhir pekan).
* **Diskon item** 0–25% (lebih tinggi untuk quantity besar).
* **Cancelled** → total 0 (sesuai logika bisnis).

---

## Cara pakai yang disarankan

* Jalankan sel 1 → 6 berurutan.
* Setelah menjalankan **langkah 5**, pakai **`orders_raw.csv` yang terbaru** (yang dioverwrite di langkah 5).
* Kalau kamu ingin **menyimpan kedua versi** (mis. “sebelum” & “sesudah” penghitungan), kamu bisa mengubah 1 baris di langkah 5 agar menyimpan dengan nama berbeda, misalnya:

```python
orders_df.to_csv("orders_raw_final.csv", index=False)  # alih-alih "orders_raw.csv"
```

dan unduh `orders_raw_final.csv`.

---

> dataset mana yang kamu buat yang membutuhkan data cleaning, karena saya notice rata rata dataset yang saya download sudah bersih, jadi saya mempertanyakannya

Wajar kok kalau sekilas kelihatan “rapi”—isu kualitas datanya memang **disebar tipis** (low rate), jadi tidak langsung muncul di beberapa baris pertama. Berikut ringkasannya per dataset + contoh cek cepat biar kamu bisa buktikan sendiri.

---

## 1) `customers_raw.csv` — **butuh cleaning (sengaja dibuat messy)**

**Isu yang ditanamkan:**

* **Duplikat `customer_id`** (±200–300) dengan detail sedikit berbeda (email/telepon/alamat).
* **`birth_date` kosong \~5%**, **`gender` kosong \~2%**.
* **Email invalid \~2.5%** (tanpa `@`, domain kosong, dipotong).
* **Format telepon tidak konsisten**: `+628…`, `08…`, `0821-xxx-xxxx`, `(021) 1234567`, dll.
* **Kasar huruf** pada nama (UPPER/mixed case).

**Cek cepat (pandas):**

```python
import pandas as pd, re
c = pd.read_csv("customers_raw.csv")

# Duplikat ID
dupes = c[c.duplicated("customer_id", keep=False)]
dupes_count = dupes["customer_id"].nunique()

# Missing
missing_birth = c["birth_date"].eq("").mean()
missing_gender = c["gender"].eq("").mean()

# Email invalid (cek sederhana)
email_re = re.compile(r"^[^@\s]+@[^@\s]+\.[^@\s]+$")
invalid_email = (~c["email"].apply(lambda x: bool(email_re.match(str(x))))).mean()

# Sampel format telepon (untuk normalisasi nanti)
c["phone"].head(10).tolist()
dupes_count, missing_birth, missing_gender, invalid_email
```

---

## 2) `products_raw.csv` — **butuh cleaning**

**Isu yang ditanamkan:**

* **`description` kosong \~3%**.
* **`stock_qty` bisa negatif** (error input).
* **`selling_price` kadang < `cost_price`** (\~6%, error harga).
* **Nama produk bisa duplikat** dengan SKU berbeda (karena kombinasi acak).

**Cek cepat:**

```python
p = pd.read_csv("products_raw.csv")
desc_missing = p["description"].eq("").mean()
neg_stock = (p["stock_qty"] < 0).sum()
price_error = (p["selling_price"] < p["cost_price"]).sum()
dup_name = p["product_name"].duplicated(keep=False).sum()
desc_missing, neg_stock, price_error, dup_name
```

---

## 3) `suppliers_raw.csv` — **butuh cleaning**

**Isu yang ditanamkan:**

* **Email invalid \~2%**.
* **Format telepon tidak konsisten**.
* **Kemungkinan duplikat `company_name`** (nama mirip, kontak berbeda).
* **Kota–negara** campur (Indonesia dominan, ada SG/MY/CN/HK) → perlu **normalisasi negara/kota**.

**Cek cepat:**

```python
s = pd.read_csv("suppliers_raw.csv")
invalid_email = (~s["email"].str.contains("@")).mean()
dup_company = s["company_name"].duplicated(keep=False).sum()
invalid_email, dup_company
```

---

## 4) `orders_raw.csv` — **sebagian besar rapi, tapi ada hal untuk validasi**

**Sengaja:**

* **Order Cancelled → total 0** (setelah langkah 5),
* **`discount_amount`** bisa besar → total dijaga `>= 0`.
* Distribusi pembayaran (lebih COD di kota lebih kecil), seasonality (Ramadan, dst).

**Cek cepat:**

```python
o = pd.read_csv("orders_raw.csv")
# Cancelled harus total=0
cancel_bad = o.query('status == "Cancelled" and total_amount != 0').shape[0]
# Total tidak boleh negatif
neg_total = (o["total_amount"] < 0).sum()
cancel_bad, neg_total
```

> Catatan: Versi `orders_raw.csv` **sebelum** langkah 5 memang placeholder (tax/total = 0). **Setelah** langkah 5, file ini **di-overwrite** menjadi versi final (tax/total terhitung dari `order_items_raw.csv`). Itu sebabnya kamu melihat “perbedaan”.

---

## 5) `order_items_raw.csv` — **butuh cleaning/validasi konsistensi**

**Isu yang secara desain “tak sama” dengan master produk:**

* **`unit_price` ≠ `selling_price`** produk persis, karena ada variasi promo (±5%) dan **weekend multiplier** (+10% akhir pekan).
* **`discount_percent`** sampai 25% (lebih tinggi untuk quantity besar).
* Bisa ada item untuk produk yang berstatus **`Out of Stock`/`Discontinued`** (data historis realistis → penjualan terjadi sebelum status berubah).

**Cek cepat:**

```python
oi = pd.read_csv("order_items_raw.csv")
p = pd.read_csv("products_raw.csv")[["product_id","selling_price"]]
merged = oi.merge(p, on="product_id", how="left")
# Cek deviasi harga item vs katalog (harus kira-kira dalam 0.95–1.05 * weekend multiplier)
ratio = merged["unit_price"] / merged["selling_price"]
ratio.describe()
```

---

## 6) `inventory_movements.csv` — **butuh cleaning/rekonsiliasi (paling “mentah”)**

**Isu yang ditanamkan:**

* **Tipe pergerakan & tanda qty**: `Stock In/Return` harus positif, `Sale` negatif, `Adjustment/Damage/Transfer` bisa ±.
* **Tidak semua penjualan direkam 1:1** sebagai movement (diambil subset realistis) → perlu **rekonsiliasi** kalau kamu mau menurunkan stok akhir dari ledger.
* **Reference ID** campur: `PO...`, `ADJ...`, `TRF...`, `ORD...` (format bervariasi).
* **Tidak ada opening balance** per produk → menghitung stok akhir dari ledger akan “ngambang” tanpa asumsi awal.

**Cek cepat:**

```python
im = pd.read_csv("inventory_movements.csv")
# Tanda qty sesuai tipe?
bad_sale_sign = im.query('movement_type == "Sale" and quantity >= 0').shape[0]
bad_return_sign = im.query('movement_type == "Return" and quantity <= 0').shape[0]
bad_stockin_sign = im.query('movement_type == "Stock In" and quantity <= 0').shape[0]
bad_sale_sign, bad_return_sign, bad_stockin_sign
```

---

## Kenapa kamu merasa “bersih” saat dilihat?

* Preview/spot-check (mis. 20–30 baris) **sering tidak kena** data yang error karena rate-nya kecil.
* Banyak isu muncul **di agregasi** (duplikat ID, proporsi missing, outlier harga/stok), bukan di satu baris jelas-jelas “rusak”.

---

## Ringkas: dataset yang **pasti** perlu cleaning

* **Pasti perlu:** `customers_raw`, `products_raw`, `suppliers_raw`, `inventory_movements.csv`.
* **Perlu validasi & konsistensi:** `order_items_raw.csv` (harga & diskon vs katalog; historis vs status produk), `orders_raw.csv` (pastikan pakai versi “final” dari langkah 5).

---

> order raw di langkah 5 apakah ada yang perlu di bersihkan atau di validasi ?

Iya—meski `orders_raw.csv` versi langkah 5 sudah “final”, tetap ada beberapa hal **wajib divalidasi** (dan kadang perlu dibersihkan), terutama agar konsisten dengan `order_items_raw.csv`:

## Checklist validasi utama (wajib)

1. **Unik**: `order_id` harus unik.
2. **Referensi pelanggan**: setiap `customer_id` harus ada di `customers_raw.csv`.
3. **Rentang tanggal**: `order_date` harus di 2023-01-01 s.d. 2024-08-16 23:59:59.
4. **Nilai yang diizinkan**:

   * `status` ∈ {Completed, Processing, Shipped, Cancelled}
   * `payment_method` ∈ {Credit Card, Bank Transfer, E-Wallet, COD}
5. **Aturan Cancelled**: jika `status=="Cancelled"` → **`tax_amount=0` dan `total_amount=0`**.
6. **Non-Cancelled**:

   * Punya minimal **1 item** di `order_items_raw.csv`.
   * **`total_amount>0`** (kalau 0, biasanya diskon/order-level terlalu besar → data perlu ditandai/dirapikan).
7. **PPN 11%**: untuk non-Cancelled, **`tax_amount == round(0.11 × subtotal_items)`**.
8. **Total**: untuk non-Cancelled, **`total_amount == max(0, subtotal + tax + shipping_cost − discount_amount)`**.
9. **Batas wajar**:

   * `shipping_cost` di 25.000–100.000,
   * `discount_amount` ≥ 0 dan wajar (generator set s.d. 2.000.000),
   * tak ada nilai negatif tak masuk akal (total, tax).

> Catatan: Dengan generator yang kubuat, poin 5, 7, 8 **seharusnya valid**. Yang paling mungkin butuh tindakan adalah poin 6 (jika ada non-Cancelled bernilai total 0 karena voucher terlalu besar) dan pengecekan referensi pelanggan.

## Panduan “cek cepat” (tempel di Colab)

```python
import pandas as pd

o  = pd.read_csv("orders_raw.csv")
oi = pd.read_csv("order_items_raw.csv")
c  = pd.read_csv("customers_raw.csv")

issues = {}

# 1) order_id unik
issues['duplicate_order_id'] = o['order_id'].duplicated().sum()

# 2) referensi customer
issues['missing_customer_ref'] = (~o['customer_id'].isin(c['customer_id'])).sum()

# 3) rentang tanggal
issues['order_date_out_of_range'] = (~o['order_date'].between('2023-01-01 00:00:00','2024-08-16 23:59:59')).sum()

# 4) nilai yang diizinkan
issues['unknown_status']  = (~o['status'].isin({'Completed','Processing','Shipped','Cancelled'})).sum()
issues['unknown_payment'] = (~o['payment_method'].isin({'Credit Card','Bank Transfer','E-Wallet','COD'})).sum()

# 5) & 9) angka non-negatif + kisaran wajar
for col in ['shipping_cost','discount_amount','tax_amount','total_amount']:
    issues[f'negative_{col}'] = (o[col] < 0).sum()
issues['shipping_cost_out_of_range'] = (~o['shipping_cost'].between(25000, 100000)).sum()
issues['discount_out_of_range'] = ((o['discount_amount'] < 0) | (o['discount_amount'] > 2_000_000)).sum()

# 6) aturan cancelled & non-cancelled
issues['cancelled_total_nonzero'] = o.query('status=="Cancelled" and (tax_amount!=0 or total_amount!=0)').shape[0]
item_counts = oi.groupby('order_id').size()
o2 = o.merge(item_counts.rename('item_count'), left_on='order_id', right_index=True, how='left').fillna({'item_count':0})
issues['noncancelled_no_items'] = o2.query('status!="Cancelled" and item_count==0').shape[0]
issues['noncancelled_total_zero'] = o2.query('status!="Cancelled" and total_amount==0').shape[0]

# 7) & 8) validasi PPN & total
subtotals = oi.groupby('order_id')['subtotal'].sum()
o2['subtotal'] = o2['order_id'].map(subtotals).fillna(0).astype(int)
o2['tax_recalc'] = (o2['subtotal']*0.11).round().astype(int)
o2['total_recalc'] = (o2['subtotal'] + o2['tax_recalc'] + o2['shipping_cost'] - o2['discount_amount']).clip(lower=0)
issues['tax_mismatch']   = ((o2['status']!='Cancelled') & (o2['tax_amount']!=o2['tax_recalc'])).sum()
issues['total_mismatch'] = ((o2['status']!='Cancelled') & (o2['total_amount']!=o2['total_recalc'])).sum()

pd.Series(issues)
```

## Jika ada temuan, apa yang “dibersihkan”?

* **Non-Cancelled total=0** → ubah ke **Cancelled** *atau* batasi `discount_amount` ≤ `subtotal + tax + shipping`.
* **`missing_customer_ref` > 0** → hapus order yatim (atau perbaiki `customer_id`).
* **Total/Tax mismatch** → **re-compute** lalu overwrite kolom.
* **Shipping/discount di luar kisaran** → clamp ke batas wajar.

Kalau mau, aku bisa kirimkan sel Colab “auto-fix” dari hasil cek di atas, yang langsung menghasilkan `orders_raw_clean.csv`.
