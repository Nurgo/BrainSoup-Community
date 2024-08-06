from __future__ import print_function
import os
import tempfile
import subprocess
import uuid

def normalize_script(source_code, destination_path):
    # Split the script into lines
    lines = source_code.split("\n")

    if not lines:
        raise ValueError("Le code source est vide")

    # Remove empty lines at the end of the script
    i = len(lines) - 1
    while i >= 0 and not lines[i].strip():
        i -= 1

    # Add print() to the last line (keep the indentation)
    if i >= 0:
        indentation = len(lines[i]) - len(lines[i].lstrip())
        lines[i] = lines[i][:indentation] + "print(" + lines[i].strip() + ")"

    # Write the normalized script to a file
    with open(destination_path, 'w') as file:
        for line in lines:
            file.write(line + '\n')

def main():
    # Retrieving the script from the environment variable
    source_code = os.getenv("ARGS_SCRIPT")
    if not source_code:
        raise ValueError("The environment variable ARGS_SCRIPT is not set")

    # Create a temporary script
    temp_dir = tempfile.gettempdir()
    temp_script_path = os.path.join(temp_dir, "temp_script_{}.py".format(uuid.uuid4().hex))

    # Normalize the script by adding a print() to the last line
    normalize_script(source_code, temp_script_path)

    # Run the script
    try:
        with open(temp_script_path, 'r') as file:
            process = subprocess.Popen(["python", "-"], stdin=file, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = process.communicate()

        if process.returncode != 0:
            print("An error has occurred while executing the script:\n", stderr.decode().strip())
        else:
            print(stdout.decode().strip())

    except Exception as e:
        print("An error has occurred while executing the script: {}".format(e))

    # Cleaning up
    os.remove(temp_script_path)

if __name__ == "__main__":
    main()
