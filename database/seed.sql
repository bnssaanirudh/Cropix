USE cropix_db;

-- Seeding Farmers Table
INSERT INTO Farmers (name, phone, location) 
VALUES 
    ('Amit Sharma', '9123456789', 'Maharashtra'),
    ('Priya Reddy', '9234567890', 'Karnataka'),
    ('Rajesh Gupta', '9345678901', 'Punjab');

-- Seeding Crops Table
INSERT INTO Crops (farmer_id, crop_name, quantity_kg, price_per_kg, harvest_date)
VALUES 
    (1, 'Corn', 600, 28.00, '2024-02-12'),
    (2, 'Barley', 400, 35.00, '2024-02-08'),
    (3, 'Soybean', 250, 45.00, '2024-02-06');

-- Seeding Markets Table
INSERT INTO Markets (market_name, location) 
VALUES 
    ('Mumbai Wholesale Market', 'Maharashtra'),
    ('Bangalore Agricultural Market', 'Karnataka'),
    ('Amritsar Grain Market', 'Punjab');

-- Seeding MarketPrices Table
INSERT INTO MarketPrices (market_id, crop_name, price_per_kg) 
VALUES 
    (1, 'Corn', 30.00),
    (2, 'Barley', 38.00),
    (3, 'Soybean', 48.00);

-- Seeding TransportServices Table
INSERT INTO TransportServices (provider_name, contact_number, vehicle_type, capacity_kg, price_per_km, available)
VALUES 
    ('Express Agri Transport', '9456789012', 'Truck', 3000, 14.00, 'Yes'),
    ('Swift Logistics', '9567890123', 'Mini Truck', 1200, 12.00, 'Yes'),
    ('Farm Link Transport', '9678901234', 'Van', 600, 8.00, 'No');

-- Seeding Logistics Table
INSERT INTO Logistics (farmer_id, transport_id, pickup_location, drop_location, distance_km, fare, status)
VALUES 
    (2, 2, 'Karnataka', 'Maharashtra', 450, 6300, 'In Transit'),
    (3, 3, 'Punjab', 'Karnataka', 700, 8500, 'Pending');

-- Seeding Transactions Table
INSERT INTO Transactions (farmer_id, crop_id, market_id, transport_id, quantity_sold, total_price, transport_cost, net_profit)
VALUES 
    (2, 2, 2, 2, 150, 150 * 38, 3000, (150 * 38) - 3000),
    (3, 3, 3, 3, 100, 100 * 48, 2500, (100 * 48) - 2500);

