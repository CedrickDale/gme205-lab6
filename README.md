# *GmE 205 Laboratory 6 — Introductory Spatial Database Modeling*

The main objective of this laboratory activity is to convert the spatial object model into a relational database using PostgreSQL and PostGIS. This involves identifying persistent object states, translating objects into database tables, establishing primary and foreign key relationships, and storing spatial geometries while preserving the identity and relationships of each object.

### Objectives

The objectives of this laboratory are to:

- Distinguish persistent object states from application methods and behaviors.
- Convert `Parcel`, `Building`, and `Road` objects into relational database tables.
- Establish primary keys and foreign keys to preserve object identity and relationships.
- Create spatial geometry columns with explicit geometry types and Spatial Reference System Identifiers (SRIDs).
- Insert sample spatial data and verify stored object attributes and relationships.
- Use relational queries and spatial functions to validate the database model.

### Tools and Technologies

The following tools were used:

- *PostgreSQL 18*
- *PostGIS 3.6.2*
- *pgAdmin 4*
- *Visual Studio Code*
- *Git*
- *GitHub*
- *SQL*
- *diagrams.net*
- *Python 3.x* (Optional)

### Database Information

- **Database Name:** `gme205_lab6`
- **PostgreSQL Version:** 18
- **PostGIS Version:** 3.6.2

### How to Set Up the Virtual Environment (Optional)

1. Open the project folder (`gme205-lab6`) in VS Code.
2. Open the terminal (`Terminal -> New Terminal`) and create the virtual environment:

   ```bash
   python -m venv .venv
   ```

3. Activate the virtual environment:

   ```bash
   .venv\Scripts\activate
   ```

4. Confirm that the terminal prompt shows `(.venv)`.
5. Select the interpreter inside `.venv` using `Ctrl + Shift + P -> Python: Select Interpreter`.

### How to Set Up the Spatial Database

1. Open pgAdmin 4 and connect to the PostgreSQL server.
2. Expand `Databases` and create a new database named `gme205_lab6`.
3. Right-click the database and select `Query Tool`.
4. Enable the PostGIS extension by executing:

   ```sql
   CREATE EXTENSION IF NOT EXISTS postgis;
   ```

5. Verify the database connection and PostGIS installation using:

   ```sql
   SELECT current_database();
   SELECT version();
   SELECT postgis_full_version();
   ```

6. Confirm that the SQL queries return the database name, PostgreSQL version, and PostGIS version.

### How to Initialize the Git Repository

1. Open the project folder (`gme205-lab6`) in VS Code.
2. Open the terminal (`Terminal -> New Terminal`).
3. Initialize the Git repository and create the initial commit:

   ```bash
   git init
   git add .
   git commit -m "Initialize Lab 6 spatial database modeling project"
 
  ```

### Object-to-Persistence Decision Table

| Object-Model Element | Persist? | Reason |
|---|---|---|
| Parcel: id, land_use, geometry | Yes | These attributes preserve the parcel's identity, land use, and spatial information. |
| Parcel: area() | No | The parcel's area can be calculated directly from its stored geometry. |
| Building: id, floors, geometry | Yes | These attributes preserve the building's identity, characteristics, and geometry. |
| Building to Parcel relationship | Yes | The relationship must be maintained to identify which parcel contains the building. |
| Road: id, road_class, geometry | Yes | These attributes preserve the road's identity, classification, and spatial information. |
| SpatialRule: evaluate(parcel) | No | This method performs an assessment and does not represent permanent spatial data. |
| HazardZone: severity | Yes | The severity classification should remain available for future hazard assessments even after the application stops running. |

## Part F.2 — Reflection Questions

### 1. Name one attribute from your object model that became a database column. Why must it persist?

The `Parcel.land_use` attribute became the `land_use` column in the `parcels` table because land-use classification is an important property that must remain available even after the program stops running. Storing this attribute allows the database to preserve parcel information and support future spatial queries, analysis, and data retrieval.

### 2. Name one method or behavior that did not become a column. Why not?

The `Parcel.area()` method did not become a database column because it represents a calculation rather than persistent state. Instead, the parcel's area can be calculated directly from its stored geometry using the PostGIS function `ST_Area()`. This avoids storing redundant information and ensures that the calculated area reflects the parcel's current geometry.

### 3. How did the Building-to-Parcel object relationship become a relational relationship?

The Building-to-Parcel relationship was implemented by adding `parcel_id` as a foreign key in the `buildings` table, referencing the `parcel_id` primary key in the `parcels` table. This establishes a one-to-many relationship where one parcel can contain multiple buildings, while each building is assigned to exactly one parcel. The relationship can be reconstructed using a SQL `JOIN`, and referential integrity is maintained through the foreign key constraint.

### 4. Why can Road proximity be discovered spatially instead of storing parcel_id in roads?

Road proximity can be determined using the PostGIS function `ST_DWithin()`, which evaluates whether road and parcel geometries are within a specified distance. Unlike the Building-to-Parcel relationship, road proximity is a spatial relationship that depends on geographic location rather than a fixed foreign key association. Using spatial queries allows proximity to be evaluated dynamically without storing unnecessary `parcel_id` references in the `roads` table.

### 5. What is the advantage of explicitly storing geometry type and SRID?

Explicitly defining geometry types ensures that each table stores the appropriate spatial features, such as Polygon geometries for parcels and buildings and LineString geometries for roads. Specifying SRID `32651` establishes a consistent projected coordinate reference system using meter-based coordinates. This supports reliable spatial operations such as `ST_Area()`, `ST_Within()`, and `ST_DWithin()`, while preventing incompatible geometry types or coordinate reference systems from being inserted into the geometry columns.
