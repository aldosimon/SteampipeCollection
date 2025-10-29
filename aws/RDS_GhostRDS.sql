--https://cybr.com/hands-on-labs/lab/hunting-for-ghost-databases-in-the-cloud/
--list RDS connection that has no conn. for the last 30d

SELECT
      db.db_instance_identifier,
      AVG(conn.average) AS avg_connections_30d,
      db.engine,
      db.allocated_storage
  FROM
      aws_rds_db_instance AS db
  JOIN
      aws_rds_db_instance_metric_connections AS conn
  ON
      db.db_instance_identifier = conn.db_instance_identifier
  WHERE
      conn.timestamp >= now() - interval '30 days'
  GROUP BY
      db.db_instance_identifier, db.engine, db.allocated_storage
  HAVING
      AVG(conn.average) = 0
  ORDER BY
      db.db_instance_identifier;
