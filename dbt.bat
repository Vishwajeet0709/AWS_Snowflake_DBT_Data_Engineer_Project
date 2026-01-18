@echo off
pushd "%~dp0aws_dbt_snowflake_project"
"%~dp0.venv\Scripts\python.exe" "%~dp0dbt_wrapper.py" %*
popd
