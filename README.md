# Netflix Graph Analytics – Neo4j

## Overview

This project implements a graph-based analytical model for Netflix content using Neo4j.  
Raw CSV data was transformed into a structured knowledge graph to enable multidimensional, hypothesis-driven analysis using Cypher.

The project demonstrates applied data engineering, graph modeling and analytical query design.

---

## Core Objectives

- Transform raw CSV data into a structured graph schema
- Implement dynamic node classification (:Movie / :TVShow)
- Clean and normalize inconsistent source data
- Design relationship-driven graph architecture
- Enrich and restructure the schema iteratively
- Validate analytical hypotheses using aggregation logic

---

## Data Engineering Pipeline

### 1. Data Import

- CSV ingestion via `LOAD CSV`
- Creation of `Title` base nodes
- Conditional labeling (`:Movie`, `:TVShow`)
- Type casting and normalization of attributes

### 2. Data Cleaning & Refactoring

- Removal of empty or invalid `Country` nodes
- Relationship pruning and restructuring
- Deduplication logic
- Schema simplification

### 3. Data Enrichment

- Creation of `AgeRating` nodes
- Controlled relationship modeling via `MERGE`
- Refactoring of duration and release year modeling
- Graph consistency validation

Implementation reference:  
`queries/data-import-and-cleaning.cql`

---

## Graph Schema Design

### Core Node Types

- `Title`
- `Movie`
- `TVShow`
- `Genre`
- `Country`
- `Continent`
- `Person`
- `AgeRating`

### Key Relationships

- `PRODUCED_IN`
- `DIRECTED_BY`
- `ACTED_IN`
- `BELONGS_TO`
- `HAS_AGERATING`
- Hierarchical `Country → Continent`

### Conceptual Model

![Graph Model](images/graph-data-model.png)

The schema enables relationship-centric exploration and aggregation beyond relational constraints.

---

## Hypothesis-Driven Analysis

### Hypothesis

Content production focus (Movie vs. TV Show ratio) differs significantly across countries.

### Analytical Logic

The Cypher query implements:

- Dual aggregation (Movie / TVShow)
- Dynamic grouping of low-volume countries into "Others"
- Global benchmark calculation ("Worldwide")
- Percentage normalization
- Ordered comparative ranking

Query reference:  
`queries/cypher-analysis-country-continent-distribution.cql`

This demonstrates advanced aggregation, conditional grouping and percentage transformation in Cypher.

---

## Geographic Hierarchical Modeling

Countries were linked to continents to enable regional roll-up analysis and hierarchical pattern detection.

![Continent Country Graph](images/continent-country-graph.png)

This structure allows continent-level aggregation and geographic production analysis.

---

## Example Analytical Output

Movie vs. TV Show distribution per country (percentage comparison):

![Country Content Distribution](images/country-content-distribution.png)

---

## Technical Stack

- Neo4j
- Cypher Query Language
- Graph Schema Modeling
- CSV Ingestion & Transformation
- Data Cleaning & Refactoring
- Aggregation & Percentage Logic
- Knowledge Graph Visualization

---

## What This Project Demonstrates

- Applied graph data engineering
- Relationship-centric modeling
- Schema refactoring and normalization
- Hypothesis-driven analytical design
- Advanced Cypher aggregation patterns
- Hierarchical geographic modeling

---

## Repository Structure

- images/ → Graph model & visualizations
- queries/ → Cypher import, cleaning & analytical logic
- full-documentation/ → Complete project documentation
- README.md → Project overview
