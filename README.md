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

