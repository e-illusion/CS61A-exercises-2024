CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT d.name FROM dogs d, dogs g, parents p WHERE d.name = p.child and g.name = p.parent ORDER BY g.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, s.size FROM dogs d,sizes s WHERE s.min < d.height AND d.height <= s.max ;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child AS sibling1, b.child AS sibling2 FROM parents a, parents b WHERE a.parent = b.parent and a.child < b.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT 'The two siblings, ' || s.sibling1 || ' and ' || s.sibling2 ||', have the same size: '|| a.size 
    FROM siblings s, size_of_dogs a,size_of_dogs b WHERE s.sibling1 = a.name and s.sibling2 = b.name and a.size = b.size;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur ,MAX(height) - MIN(height) FROM dogs GROUP BY fur HAVING MIN(height) >= 0.7 * AVG(height) AND MAX(height) <= 1.3 * AVG(height);

