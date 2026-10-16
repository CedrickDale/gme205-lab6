SELECT parcel_id, land_use, ST_Area(geom) AS area_sqm
FROM lab6.parcels;

SELECT b.building_id,
       b.floors,
       p.parcel_id,
       p.land_use
FROM lab6.buildings AS b
JOIN lab6.parcels AS p
  ON p.parcel_id = b.parcel_id;

SELECT b.building_id,
       p.parcel_id,
       ST_Within(b.geom, p.geom) AS is_inside
FROM lab6.buildings AS b
JOIN lab6.parcels AS p
  ON p.parcel_id = b.parcel_id;

SELECT p.parcel_id,
       r.road_id,
       ST_DWithin(p.geom, r.geom, 15) AS within_15m
FROM lab6.parcels AS p
CROSS JOIN lab6.roads AS r;
