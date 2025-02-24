CREATE DATABASE cropix_db;
USE cropix_db;
CREATE TABLE Farmers (
    farmer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    location VARCHAR(255) NOT NULL,
    registered_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO Farmers (name, phone, location) 
VALUES ('Ravi Kumar', '9876543210', 'Andhra Pradesh'),
       ('Meena Devi', '8765432119', 'Tamil Nadu');
       SELECT * FROM Farmers;

CREATE TABLE Crops (
    crop_id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_id INT NOT NULL,
    crop_name VARCHAR(100) NOT NULL,
    quantity_kg DECIMAL(10,2) NOT NULL,
    price_per_kg DECIMAL(10,2) NOT NULL,
    harvest_date DATE NOT NULL,
    status ENUM('Available', 'Sold') DEFAULT 'Available',
    FOREIGN KEY (farmer_id) REFERENCES Farmers(farmer_id) ON DELETE CASCADE
);
 INSERT INTO Crops (farmer_id, crop_name, quantity_kg, price_per_kg, harvest_date)
VALUES (1, 'Wheat', 500, 30.50, '2024-02-10'),
       (2, 'Rice', 300, 40.75, '2024-02-05');
       
       CREATE TABLE Markets (
    market_id INT AUTO_INCREMENT PRIMARY KEY,
    market_name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL
);
INSERT INTO Markets (market_name, location) 
VALUES ('Chennai Market', 'Tamil Nadu'),
       ('Hyderabad Market', 'Telangana');
       SHOW DATABASES;
USE cropix_db;
 CREATE TABLE MarketPrices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    market_id INT NOT NULL,
    crop_name VARCHAR(100) NOT NULL,
    price_per_kg DECIMAL(10,2) NOT NULL,
    updated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (market_id) REFERENCES Markets(market_id) ON DELETE CASCADE
);
INSERT INTO MarketPrices (market_id, crop_name, price_per_kg) 
VALUES (1, 'Wheat', 32.00),
       (2, 'Rice', 42.00);
CREATE TABLE TransportServices (
    transport_id INT AUTO_INCREMENT PRIMARY KEY,
    provider_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    vehicle_type VARCHAR(50),
    capacity_kg DECIMAL(10,2),
    price_per_km DECIMAL(10,2),
    available ENUM('Yes', 'No') DEFAULT 'Yes'
);
INSERT INTO TransportServices (provider_name, contact_number, vehicle_type, capacity_kg, price_per_km)
VALUES ('Fast Transport', '9123456789', 'Truck', 2000, 15.00),
       ('Agri Movers', '9234567891', 'Mini Truck', 1000, 10.00);
CREATE TABLE Logistics (
    logistics_id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_id INT NOT NULL,
    transport_id INT NOT NULL,
    pickup_location VARCHAR(255) NOT NULL,
    drop_location VARCHAR(255) NOT NULL,
    distance_km DECIMAL(10,2) NOT NULL,
    fare DECIMAL(10,2) NOT NULL,
    status ENUM('Pending', 'In Transit', 'Delivered') DEFAULT 'Pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES Farmers(farmer_id) ON DELETE CASCADE,
    FOREIGN KEY (transport_id) REFERENCES TransportServices(transport_id) ON DELETE CASCADE
);
INSERT INTO Logistics (farmer_id, transport_id, pickup_location, drop_location, distance_km, fare, status)
VALUES (1, 1, 'Andhra Pradesh', 'Tamil Nadu', 500, 7500, 'Pending');
SELECT m.market_name, mp.crop_name, mp.price_per_kg 
FROM MarketPrices mp 
JOIN Markets m ON mp.market_id = m.market_id 
WHERE mp.crop_name = 'Wheat';
SELECT * FROM TransportServices WHERE available = 'Yes';
SELECT l.logistics_id, f.name AS farmer_name, t.provider_name, l.status 
FROM Logistics l 
JOIN Farmers f ON l.farmer_id = f.farmer_id
JOIN TransportServices t ON l.transport_id = t.transport_id;

 
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_id INT NOT NULL,
    crop_id INT NOT NULL,
    market_id INT NOT NULL,
    transport_id INT NOT NULL,
    quantity_sold DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    transport_cost DECIMAL(10,2) NOT NULL,
    net_profit DECIMAL(10,2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
   
    FOREIGN KEY (farmer_id) REFERENCES Farmers(farmer_id) ON DELETE CASCADE,
    FOREIGN KEY (crop_id) REFERENCES Crops(crop_id) ON DELETE CASCADE,
    FOREIGN KEY (market_id) REFERENCES Markets(market_id) ON DELETE CASCADE,
    FOREIGN KEY (transport_id) REFERENCES TransportServices(transport_id) ON DELETE CASCADE
);

INSERT INTO Transactions (farmer_id, crop_id, market_id, transport_id, quantity_sold, total_price, transport_cost, net_profit)
VALUES (
    1,  -- Farmer Ravi Kumar
    1,  -- Wheat Crop
    1,  -- Chennai Market
    1,  -- Fast Transport
    100, 
    100 * 32,  -- 100 kg * ₹32/kg
    2500, 
    (100 * 32) - 2500  -- Net Profit = Total Price - Transport Cost
);

SELECT 
    t.transaction_id, 
    f.name AS farmer_name, 
    c.crop_name, 
    m.market_name, 
    ts.provider_name AS transport_service, 
    t.quantity_sold, 
    t.total_price, 
    t.transport_cost, 
    t.net_profit, 
    t.transaction_date 
FROM Transactions t
JOIN Farmers f ON t.farmer_id = f.farmer_id
JOIN Crops c ON t.crop_id = c.crop_id
JOIN Markets m ON t.market_id = m.market_id
JOIN TransportServices ts ON t.transport_id = ts.transport_id;






       
