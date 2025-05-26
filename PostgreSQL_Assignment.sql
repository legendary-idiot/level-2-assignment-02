-- Create Rangers Table
CREATE TABLE Rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(150) NOT NULL
);

-- Create Species Table
CREATE TABLE Species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(150) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);

-- Create Sightings Table
CREATE TABLE Sightings (
    sighting_id SERIAL PRIMARY KEY UNIQUE,
    ranger_id INT NOT NULL REFERENCES Rangers(ranger_id),
    species_id INT NOT NULL REFERENCES Species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(255) NOT NULL,
    notes TEXT
);

-- Insert Sample Data into Rangers Table
INSERT INTO Rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

-- Insert Sample Data into Species Table
INSERT INTO Species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- Insert Sample Data into Sightings Table
INSERT INTO Sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

-- View All Rangers
SELECT * FROM Rangers;

-- View All Species
SELECT * FROM Species;

-- View All Sightings
SELECT * FROM Sightings;



-- Problem 1:
INSERT INTO Rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2:
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM Sightings;

-- Problem 3:
SELECT * FROM sightings
WHERE location ILIKE '%Pass%';

-- Problem 4:
SELECT Rangers.name AS ranger_name, COUNT(Sightings.sighting_id) AS total_sightings
FROM Rangers
LEFT JOIN Sightings ON Rangers.ranger_id = Sightings.ranger_id
GROUP BY Rangers.name
HAVING COUNT(Sightings.sighting_id) > 0
ORDER BY ranger_name;

-- Problem 5:
SELECT common_name
FROM Species
LEFT JOIN Sightings ON Species.species_id = Sightings.species_id
WHERE sighting_id IS NULL;

-- Problem 6: 
SELECT sp.common_name, s.sighting_time,  r.name AS ranger_name
FROM Sightings s
JOIN Species sp ON s.species_id = sp.species_id
JOIN Rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Problem 7: 
UPDATE Species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


-- Problem 8:
SELECT s.sighting_id,
       CASE 
           WHEN EXTRACT(HOUR FROM s.sighting_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM s.sighting_time) < 18 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_of_day
FROM Sightings s
JOIN Species sp ON s.species_id = sp.species_id
JOIN Rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time;

-- Problem 9: 
DELETE FROM Rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM Sightings
);
