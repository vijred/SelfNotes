
Quick way to connect and validate a connection to neo4j server (bash)

```
python - <<'PY'
from neo4j import GraphDatabase

URI = "bolt://12.12.12.12:7687"
USER = "asfdasdf"
PASSWORD = "sfsdffsd"

driver = GraphDatabase.driver(
    URI,
    auth=(USER, PASSWORD)
)

try:
    with driver.session() as session:
        result = session.run("RETURN 1 AS test")
        record = result.single()
        print("SUCCESS")
        print(record["test"])
except Exception as e:
    print("ERROR")
    print(repr(e))
finally:
    driver.close()
PY
```
