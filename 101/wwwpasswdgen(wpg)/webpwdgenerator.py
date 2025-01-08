from flask import Flask, jsonify
import subprocess
import os
#Want to eventually make this a web app that can be accessed from a browser to generate a password
app = Flask(__name__)

# Set environment variables for Azure authentication
#os.environ["ARM_CLIENT_ID"] = "<your-client-id>"
#os.environ["ARM_CLIENT_SECRET"] = "<your-client-secret>"
#os.environ["ARM_SUBSCRIPTION_ID"] = "<your-subscription-id>"
#os.environ["ARM_TENANT_ID"] = "<your-tenant-id>"

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