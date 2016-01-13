# SIBYL database schema
## author [Massimiliano Pittore](mailto:pittore@gfz-potsdam.de)
 
the present postgresql / postgis schema is based on the SENSUM db schema, which employs the GEM v2.0 taxonomy.

There are four main namespaces (or schemas):

* survey
* taxonomy
* asset
* image

and a separated namespace, *history*, which enables the loggin of every modification taking place in the database.


## Survey
This namespace contains the basic information of the surveys carried out. Each survey is associate a type, specified in the table *survey_type*, a name and a description.

## Taxonomy
The main descriptors of the implemented taxonomies are defined here. A taxonomy is composed by attributes and qualifiers. 
Attributes can be nested in cases (where sub-attributes can be specified). All attributes are independent. 
Qualifiers add information to the attributes, while attributs contribute to describe a single object, which is an element of the *asset* namespace.

## Asset
Depends on *Taxonomy* and *Survey*.
This namespace contains a set of tables describing the individual objects (or assets), by a combination of attributes and qualifiers.

## Image
Depends on *Survey*.
The visual information used (or to be used) to characterize the assets are defined in the tables contained in this namespace.
Different types of images can be used, as specified by the entries in the table *image_type* currently only omnidirectional images and generic pictures are accounted for.
Georeferencing of the images is specified through the *GPS* table, which contains information on the absolute position, velocity and azimuthal pose of the camera. 
The gpano metadata are also included to provide a xmp-compliant support for the spherical image standard metadata proposed by Google.
  

#Installation

Use the script *create_templatedb.sh* to create a database with the necessary extensions, structures and functions.
Usage: *sh create_templatedb.sh namedb*.

Use the script *populate_testdata.sql* to load 200 assets (buildings) in the database.
Usage: *psql namedb -f populate_testdata.sql*.

##dependencies
* PostgreSQL >=9.2
* PostGIS >= 2.0
