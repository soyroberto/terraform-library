from flask import Flask, jsonify
from flask_cors import CORS #This is to allow cross-origin requests
import subprocess
import os
#Want to eventually make this a web app that can be accessed from a browser to generate a password
app = Flask(__name__)
#CORS(app, origins=["http://127.0.0.1:8000"])
#CORS(app, origins=["http://192.168.2.235:8000"])
CORS(app)
# Set environment variables for Azure authentication
# os.environ["ARM_CLIENT_ID"] = 
# os.environ["ARM_CLIENT_SECRET"] = "
# os.environ["ARM_TENANT_ID"] = 
# os.environ["ARM_SUBSCRIPTION_ID"] = 

@app.route("/generate-password", methods=["GET"])
def generate_password():
    try:
        # Run Terraform commands
        subprocess.run(["terraform", "init"], check=True)
        subprocess.run(["terraform", "apply", "-auto-approve"], check=True)

        # Retrieve the generated password from Terraform output
        result = subprocess.run(["terraform", "output", "-json", "espassword"], capture_output=True, text=True, check=True)
        password = result.stdout.strip()

        return jsonify({"password": password}), 200
    except subprocess.CalledProcessError as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=100)