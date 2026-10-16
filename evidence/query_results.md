
# Laboratory 6 — Query Results

### Query 1 — Persistent State

| parcel_id | land_use | area_sqm |
|---|---|---|
| P-001 | Residential | 10000 |

**Interpretation:**

The query confirms that the parcel's identity, land use, and geometry are stored in the database, while its area is calculated using ST_Area().

### Query 2 — Object Relationship to Foreign Key

| building_id | floors | parcel_id | land_use |
|---|---|---|---|
| B-001 | 2 | P-001 | Residential |

**Interpretation:**

The JOIN reconstructs the Building-to-Parcel relationship by matching buildings.parcel_id (foreign key) with parcels.parcel_id (primary key).

### Query 3 — Topological Check

| building_id | parcel_id | is_inside |
|---|---|---|
| B-001 | P-001 | true |

**Interpretation:**

The ST_Within() function confirms that the building's geometry is inside its assigned parcel, consistent with their foreign key relationship.

### Query 4 — Spatial Relationship

| parcel_id | road_id | within_15m |
|---|---|---|
| P-001 | R-001 | true |

**Interpretation:**

The ST_DWithin() function confirms that the road is within 15 meters of the parcel without requiring a foreign key.
