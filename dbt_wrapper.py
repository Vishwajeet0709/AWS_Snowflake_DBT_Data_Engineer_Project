import sys
from dbt.cli.main import dbtRunner

if __name__ == "__main__":
    # Remove the script name from args
    args = sys.argv[1:]
    res = dbtRunner().invoke(args)
    
    # dbtRunner returns a dbtResult object
    if not res.success:
        if res.exception:
            print(f"Error: {res.exception}", file=sys.stderr)
        sys.exit(1)
